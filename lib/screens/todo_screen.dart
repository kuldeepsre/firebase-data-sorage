import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/TodoProvider.dart';


class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TodoProvider>().fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<TodoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),

      body: provider.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )

          : provider.error != null
          ? Center(
        child: Text(provider.error!),
      )

          : ListView.builder(
        itemCount: provider.todos.length,

        itemBuilder: (context, index) {

          final todo = provider.todos[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),

            child: ListTile(
              leading: CircleAvatar(
                child: Text(todo.id.toString()),
              ),

              title: Text(todo.title.toString()),

              subtitle: Text(
                'User ID : ${todo.userId}',
              ),

              trailing: Icon(
                todo.completed
                    ? Icons.check_circle
                    : Icons.cancel,

                color: todo.completed
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}