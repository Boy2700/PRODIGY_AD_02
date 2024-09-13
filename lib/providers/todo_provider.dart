import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../services/todo_database.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  Future<void> loadTodos() async {
    _todos = await TodoDatabase.instance.getTodos();
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await TodoDatabase.instance.insertTodo(todo);
    _todos.add(todo);
    notifyListeners();
  }

  Future<void> updateTodo(Todo todo) async {
    await TodoDatabase.instance.updateTodo(todo);
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(int id) async {
    await TodoDatabase.instance.deleteTodo(id);
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}
