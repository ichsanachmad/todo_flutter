import 'package:equatable/equatable.dart';
import 'package:todo_flutter/data/model/todo.dart';

class ToDoState extends Equatable {
  @override
  List<Object> get props => [];
}

class ToDoInitialState extends ToDoState {}

class ToDoLoadingState extends ToDoState {}

class ToDoSuccessLoadState extends ToDoState {
  final List<ToDo> toDos;

  ToDoSuccessLoadState(this.toDos);

  @override
  List<Object> get props => [toDos];
}

class ToDoActionSuccessState extends ToDoState {}


class ToDoActionFailedState extends ToDoState {}