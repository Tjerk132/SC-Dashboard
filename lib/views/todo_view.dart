import 'package:flutter/material.dart';
import 'package:flutter_test_project/controllers/todo_view_controller.dart';
import 'package:flutter_test_project/data/todo_dao.dart';

import '../models/todo.dart';

TextEditingController _textEditController = new TextEditingController();

class TodoView extends StatefulWidget {
  TodoView({Key key, this.controller}) : super(key: key);

  final TodoViewController controller;

  @override
  State<StatefulWidget> createState() => TodoViewState(controller: controller);
}

class TodoViewState extends State<TodoView> {

  List<Todo> todos;
  TodoDao dao;

  final TodoViewController controller;

  TodoViewState({this.controller}) {
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
        todos.insert(0, todo);
        _textEditController.clear();
      }
    });
  }

  removeTodo(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  @override
  Widget build(BuildContext context) {

    Size contextSize = MediaQuery.of(context).size;

    return Column(children: <Widget>[
        ListView.builder(
            reverse: true,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index];
              return IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: contextSize.width * 0.6,
                      height: contextSize.height * 0.2,
                      child: GestureDetector(
                        onTap: () => setState(() => todo.toggleCompleted()),
                        child: Center(
                          child: Text(todo.title,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 22.0,
                                  decoration: todo.completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none)),
                        ),
                      ),
                    ),
                    Container(
                      width: contextSize.width * 0.4,
                      child: FlatButton(
                        onPressed: () => removeTodo(todo),
                        child: Center(
                          child: Text('remove'),
                        ),
                      ),
                    ), // Expanded(...)
                  ],
                ),
              );
            }),
        Container(
          padding: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: TextField(
            controller: _textEditController,
            style: new TextStyle(fontSize: 22.0),
            decoration: InputDecoration(hintText: 'Enter new todo'),
            onSubmitted: (value) => addTodo(),
          ),
        ),
      ]
    );
  }
}
