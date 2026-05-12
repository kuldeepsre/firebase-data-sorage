import 'package:dpl/model/post_responnse.dart';
import 'package:dpl/services/api_services.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';



class TodoProvider extends ChangeNotifier {
  final ApiServices _apiService = ApiServices();

  List<TodoModel> _todos = [];

  bool _isLoading = false;

  String? _error;

  List<TodoModel> get todos => _todos;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchTodos() async {
    _isLoading = true;

    notifyListeners();

    try {
      _todos = await _apiService.fetchTodos();

      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }
}