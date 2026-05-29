import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiProvider extends ChangeNotifier {

  final String apiUrl =
      'https://jsonplaceholder.typicode.com/posts';

  bool _isLoading = false;

  String _result = '';

  bool get isLoading => _isLoading;

  String get result => _result;

  Future<void> postData({
    required String name,
    required String email,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type':
          'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'email': email,
        }),
      );

      if (response.statusCode == 201) {
        final responseData =
        jsonDecode(response.body);
        _result =
        'ID: ${responseData['id']}\n'

           ;
      } else {
        _result = 'Failed to post data';
      }
    } catch (e) {
      _result = 'Error: $e';
    }
    _isLoading = false;
    notifyListeners();
  }
}