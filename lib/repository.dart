import 'dart:convert';

import 'package:flutter_crud_learning/model.dart';
import 'package:http/http.dart' as http;

class DataRepository {
  final http.Client httpClient;

  DataRepository(this.httpClient);

  Future<List<TodoModel>> fetchTodos() async {
    final response = await httpClient
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> todoData = json.decode(response.body);
      return todoData.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch todos.');
    }
  }

  Future<List<TodoModel>> addTodo(TodoModel todo) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
        body: json.encode(todo.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final dynamic data = json.decode(response.body);
        final updatedTodo = TodoModel.fromJson(data);
        final currentTodos = await fetchTodos();
        final updatedTodos = [...currentTodos, updatedTodo];
        return updatedTodos;
      } else {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodoById(TodoModel todo) async {
    final response = await httpClient.put(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo.id}'),
      body: jsonEncode(todo.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo.');
    }
  }

  Future<void> deleteTodoById(int id) async {
    final response = await http
        .delete(Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
