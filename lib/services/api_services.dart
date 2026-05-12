import 'dart:convert';

import 'package:dpl/model/post_responnse.dart';
import 'package:http/http.dart' as http;

import '../model/todo.dart';

class ApiServices{
  Future<List<PostResponse>>  fetchPost() async{

    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if(response.statusCode==200){
      List Data=jsonDecode(response.body);
       print("Data $Data");
       return  Data.map((e)=>PostResponse.fromJson(e)).toList();
    }
    else{
      throw Exception("failed data");
    }
  }
  Future<List<TodoModel>> fetchTodos() async {
    final response = await http.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/todos',
      ),
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);

      return jsonData
          .map((e) => TodoModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}