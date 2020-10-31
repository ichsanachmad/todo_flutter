import 'package:equatable/equatable.dart';
import 'package:todo_flutter/data/model/todo.dart';

class ToDoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToDoEventLoadToDoList extends ToDoEvent {}

class ToDoEventUpdateToDoList extends ToDoEvent {
  final List<ToDo> toDos;

  ToDoEventUpdateToDoList(this.toDos);

  @override
  List<Object> get props => [toDos];
}

class ToDoEventInsertToDoAction extends ToDoEvent{
 final ToDo toDo;

  ToDoEventInsertToDoAction(this.toDo);

  @override
  List<Object> get props => [toDo];
}

class ToDoEventUpdateToDoAction extends ToDoEvent{
 final ToDo toDo;

  ToDoEventUpdateToDoAction(this.toDo);

  @override
  List<Object> get props => [toDo];
}
