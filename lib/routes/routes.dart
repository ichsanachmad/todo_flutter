import 'package:flutter/material.dart';
import 'package:todo_flutter/ui/home.dart';
import 'package:todo_flutter/ui/insert_todo.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() =>
      {Home.ROUTE: (_) => Home(), InsertToDo.ROUTE: (_) => InsertToDo()};
}
