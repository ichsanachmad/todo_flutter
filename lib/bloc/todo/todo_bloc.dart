import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/bloc/blocs.dart';
import 'package:todo_flutter/data/model/models.dart';
import 'package:todo_flutter/data/repository/repositories.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final _toDoRepository = ToDoRepositoryImpl();
  StreamSubscription _toDoSubscription;

  ToDoBloc() : super(ToDoInitialState());

  @override
  Stream<ToDoState> mapEventToState(ToDoEvent event) async* {
    if (event is ToDoEventLoadToDoList) {
      yield ToDoLoadingState();
      _loadToDoList();
    } else if (event is ToDoEventUpdateToDoList) {
      yield ToDoSuccessLoadState(event.toDos);
    } else if (event is ToDoEventInsertToDoAction) {
      yield ToDoLoadingState();
      yield _insertToDo(event.toDo);
    } else if (event is ToDoEventUpdateToDoAction) {
      yield _updateToDo(event.toDo);
    } else if (event is ToDoEventDeleteToDoAction) {
      yield _deleteToDo(event.id);
    }
  }

  void _loadToDoList() {
    _toDoSubscription?.cancel();
    _toDoSubscription = _toDoRepository.getToDoList().listen((event) {
      add(ToDoEventUpdateToDoList(event));
    });
  }

  ToDoState _insertToDo(ToDo toDo) {
    try {
      _toDoRepository.insertToDo(toDo);
      return ToDoActionSuccessState();
    } catch (_) {
      return ToDoActionFailedState();
    }
  }

  ToDoState _updateToDo(ToDo toDo) {
    try {
      _toDoRepository.updateToDo(toDo);
      return ToDoActionSuccessState();
    } catch (_) {
      return ToDoActionFailedState();
    }
  }

  ToDoState _deleteToDo(String id) {
    try {
      _toDoRepository..deleteToDo(id);
      return ToDoActionSuccessState();
    } catch (_) {
      return ToDoActionFailedState();
    }
  }

  @override
  Future<void> close() {
    _toDoSubscription?.cancel();
    return super.close();
  }
}
