import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/bloc/blocs.dart';
import 'package:todo_flutter/data/model/models.dart';
import 'package:todo_flutter/ui/insert_todo.dart';
import 'package:todo_flutter/widgets/list_item_todo.dart';
import 'package:todo_flutter/widgets/widget_background_home.dart';

class Home extends StatelessWidget {
  static const ROUTE = '/';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoBloc>(
      create: (_) => ToDoBloc(),
      child: HomeContainer(),
    );
  }
}

class HomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE4D4),
      body: Stack(
        children: [WidgetBackgroundHome(), HomeToDoList()],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF425195),
        onPressed: () {
          Navigator.pushNamed(context, InsertToDo.ROUTE);
        },
      ),
    );
  }
}

class HomeToDoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeToDoListState();
}

class HomeToDoListState extends State<HomeToDoList> {
  @override
  void initState() {
    context.bloc<ToDoBloc>().add(ToDoEventLoadToDoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ToDoBloc, ToDoState>(
        listener: (_, state) {
          if (state is ToDoLoadingState) {
            print("on loading...");
          } else if (state is ToDoSuccessLoadState) {
            print("on success load");
          } else if (state is ToDoActionSuccessState) {
            print("on success action");
          } else if (state is ToDoActionFailedState) {
            print("on failed action");
          } else if (state is ToDoInitialState) {
            print("on init");
          }
        },
        child: ToDoListComponent());
  }
}

class ToDoListComponent extends StatefulWidget {
  @override
  _ToDoListComponentState createState() => _ToDoListComponentState();
}

class _ToDoListComponentState extends State<ToDoListComponent> {
  List<ToDo> listToDo = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: ListView(children: [
          Text(
            'Flutter ToDo',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          BlocBuilder<ToDoBloc, ToDoState>(
            builder: (_, state) {
              if (state is ToDoSuccessLoadState) {
                listToDo = state.toDos;
              }
              return ListView.builder(
                  itemCount: listToDo.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                        key: Key(listToDo[index].id),
                        onDismissed: (_) {
                          context.bloc<ToDoBloc>().add(
                              ToDoEventDeleteToDoAction(listToDo[index].id));
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "To Do ${listToDo[index].subject} Deleted"),
                          ));

                          setState(() {
                            listToDo.removeAt(index);
                          });
                        },
                        child: ListItemToDo(toDo: listToDo[index]));
                  });
            },
          ),
        ]));
  }
}
