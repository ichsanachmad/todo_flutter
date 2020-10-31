import 'package:todo_flutter/data/model/models.dart';

abstract class ToDoRepository {
  Stream<List<ToDo>> getToDoList();
  Future<void> insertToDo(ToDo toDo);
  Future<void> updateToDo(ToDo toDo);
  Future<void> deleteToDo(String id);
}
