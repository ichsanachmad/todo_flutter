import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/bloc/todo/todo_bloc.dart';
import 'package:todo_flutter/bloc/todo/todo_event.dart';
import 'package:todo_flutter/bloc/todo/todo_state.dart';
import 'package:todo_flutter/data/model/todo.dart';
import 'package:todo_flutter/widgets/widget_background_home.dart';

class InsertToDo extends StatelessWidget {
  static const ROUTE = "/inserttodo";
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoBloc>(
      create: (_) => ToDoBloc(),
      child: InsertToDoContainer(),
    );
  }
}

class InsertToDoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFBE4D4),
        body: BlocListener<ToDoBloc, ToDoState>(
          listener: (_, state) {
            if (state is ToDoLoadingState) {
            } else if (state is ToDoActionSuccessState) {
              Navigator.pop(context);
            } else if (state is ToDoActionFailedState) {}
          },
          child: BlocBuilder<ToDoBloc, ToDoState>(
            builder: (_, state) {
              return Stack(
                children: [WidgetBackgroundHome(), InsertToDoComponent()],
              );
            },
          ),
        ));
  }
}

class InsertToDoComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InsertToDoState();
}

class InsertToDoState extends State<InsertToDoComponent> {
  final _formKey = GlobalKey<FormState>();
  final _subjectTextController = TextEditingController();
  final _bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subjectTextController.dispose();
    _bodyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              'Add ToDo',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: TextFormField(
                        controller: _subjectTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Fill Subject Field";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Subject",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        controller: _bodyTextController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Fill Body Field";
                          }
                          return null;
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: "Body",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      )),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            context.bloc<ToDoBloc>().add(
                                ToDoEventInsertToDoAction(ToDo('',
                                    body: _bodyTextController.text,
                                    isComplete: false,
                                    noted: Timestamp.now(),
                                    subject: _subjectTextController.text)));
                          }
                        },
                        child: Text('Submit'),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
