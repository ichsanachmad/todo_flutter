import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_flutter/constant/firebase_constant.dart';
import 'package:todo_flutter/data/model/todo.dart';

class ToDoNetwork {
  final _toDoCollection =
      FirebaseFirestore.instance.collection(FirebaseConstant.TASKS);
  Stream<List<ToDo>> getToDoList() {
    final toDoQuery =
        _toDoCollection.orderBy(FirebaseConstant.NOTED, descending: true);
    return toDoQuery.snapshots().map((e) {
      return e.docs.map((value) => ToDo.fromSnapshots(value)).toList();
    });
  }

  Future<void> insertToDo(ToDo toDo) {
    return _toDoCollection.add(toDo.toDocument());
  }

  Future<void> updateToDo(ToDo toDo) {
    toDo.isComplete = !toDo.isComplete;
    return _toDoCollection.doc(toDo.id).update(toDo.toDocument());
  }
}
