import 'package:todo_flutter/data/model/todo.dart';
import 'package:todo_flutter/data/network/todo_network.dart';
import 'package:todo_flutter/data/repository/todo_repository.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final _toDoNetwork = ToDoNetwork();

  @override
  Stream<List<ToDo>> getToDoList() {
    try {
      return _toDoNetwork.getToDoList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> insertToDo(ToDo toDo) {
    try {
      return _toDoNetwork.insertToDo(toDo);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateToDo(ToDo toDo) {
    try {
      return _toDoNetwork.updateToDo(toDo);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteToDo(String id) {
      try {
      return _toDoNetwork.deleteToDo(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
