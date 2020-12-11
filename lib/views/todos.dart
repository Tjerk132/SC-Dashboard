import 'package:flutter/material.dart';
import 'package:flutter_test_project/controllers/todo_view_controller.dart';
import 'package:flutter_test_project/data/todo_dao.dart';

import '../models/todo.dart';

class Todos extends StatefulWidget {
  Todos({Key key, this.controller}) : super(key: key);

  final TodoViewController controller;

  @override
  State<Todos> createState() => TodosState(controller: controller);
}

class TodosState extends State<Todos> {
  List<Todo> todos;
  TodoDao dao;

  TextEditingController _textEditController = new TextEditingController();

  final TodoViewController controller;

  TodosState({this.controller}) {
    todos = new List<Todo>();
    dao = new TodoDao();
    this.controller.addTodo = addTodo;
  }

  @override
  void initState() {
    super.initState();
//    getTodos();
  }

  getTodos() async {
    await dao.fetchTodos().then((data) {
      setState(() => todos = data.cast<Todo>());
    });
  }

  addTodo() {
    Todo todo = Todo(title: _textEditController.text);
    setState(() {
      if (todo.isValid()) {
        todos.add(todo);
        _textEditController.clear();
      }
    });
  }

  removeTodo(Todo todo) {
    setState(() => todos.remove(todo));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index];
              return Row(
                children: <Widget>[
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.2,
                    child: GestureDetector(
                      onTap: () => setState(() => todo.toggleCompleted()),
                      child: Center(
                        child: Text(
                          todo.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
                            decoration: todo.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    child: FlatButton(
                      onPressed: () => removeTodo(todo),
                      child: Center(
                        child: Text('remove'),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: TextField(
                controller: _textEditController,
                style: TextStyle(fontSize: 22.0),
                decoration: InputDecoration(hintText: 'Enter new todo'),
                onSubmitted: (value) => addTodo(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
