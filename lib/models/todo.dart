import 'package:flutter/cupertino.dart';

class Todo {

  String title;
  bool completed;

  Todo({@required this.title, this.completed = false});

  bool isValid() => title.isNotEmpty;

  void toggleCompleted() => this.completed = !this.completed;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      completed: json['completed'],
    );
  }

  @override
  String toString() {
    return '${this.title} & ${this.completed}';
  }
}