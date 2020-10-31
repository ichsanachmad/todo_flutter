import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/bloc/todo/todo_event.dart';
import 'package:todo_flutter/bloc/todo/todo_state.dart';
import 'package:todo_flutter/data/model/todo.dart';
import 'package:todo_flutter/data/repository/todo_repository_impl.dart';

class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final _toDoRepository = ToDoRepositoryImpl();
  StreamSubscription _toDoSubscription;

  ToDoBloc() : super(ToDoInitialState());

  @override
  Stream<ToDoState> mapEventToState(ToDoEvent event) async* {
    yield ToDoLoadingState();

    if (event is ToDoEventLoadToDoList) {
      yield* _loadToDoList();
    } else if (event is ToDoEventUpdateToDoList) {
      yield ToDoSuccessLoadState(event.toDos);
    } else if (event is ToDoEventInsertToDoAction) {
      yield* _insertToDo(event.toDo);
    } else if (event is ToDoEventUpdateToDoAction) {
      yield* _updateToDo(event.toDo);
    }
  }

  Stream<ToDoState> _loadToDoList() async* {
    _toDoSubscription?.cancel();
    _toDoSubscription = _toDoRepository.getToDoList().listen((event) {
      add(ToDoEventUpdateToDoList(event));
    });
  }

  Stream<ToDoState> _insertToDo(ToDo toDo) async* {
    try {
      _toDoRepository.insertToDo(toDo);
      yield ToDoActionSuccessState();
    } catch (e) {
      yield ToDoActionFailedState();
    }
  }

  Stream<ToDoState> _updateToDo(ToDo toDo) async* {
    try {
      _toDoRepository.updateToDo(toDo);
      yield ToDoActionSuccessState();
    } catch (e) {
      yield ToDoActionFailedState();
    }
  }
}
