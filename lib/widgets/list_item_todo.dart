import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/bloc/todo/todo_bloc.dart';
import 'package:todo_flutter/bloc/todo/todo_event.dart';
import 'package:todo_flutter/data/model/todo.dart';

class ListItemToDo extends StatefulWidget {
  final ToDo toDo;

  ListItemToDo({@required this.toDo});

  @override
  _ListItemToDoState createState() => _ListItemToDoState();
}

class _ListItemToDoState extends State<ListItemToDo> {
  @override
  Widget build(BuildContext context) {
    Color sideColor = widget.toDo.isComplete ? Colors.green : Colors.red;

    return Material(
        color: Colors.transparent,
        child: Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: InkWell(
                    child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 5,
                        height: 80,
                        decoration: BoxDecoration(
                            color: sideColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  widget.toDo.subject,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Text(
                                  widget.toDo.body,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                    widget.toDo.noted.toDate().toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)))
                          ],
                        ),
                      )),
                      Container(
                          child: Checkbox(
                        onChanged: (bool value) async {
                          context
                              .bloc<ToDoBloc>()
                              .add(ToDoEventUpdateToDoAction(widget.toDo));
                        },
                        value: widget.toDo.isComplete,
                      )),
                    ],
                  ),
                )))));
  }
}
