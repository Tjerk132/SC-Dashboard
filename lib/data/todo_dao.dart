import 'package:flutter_test_project/models/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoDao {

  Future<List<Todo>> fetchTodos() async {

    final response = await http.get('https://jsonplaceholder.typicode.com/todos');
    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map<Todo>((item) => Todo.fromJson(item)).toList();
    }
    else
      throw Exception('Failed to load todos');
  }

}