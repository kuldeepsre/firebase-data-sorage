import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'StudentProvider.dart';
import 'model/student_model.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              exit(0);

            },
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Center(
                child: Text(
                  "Tap Me!",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ),
          const Center(child: Text("Splash")),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();

  void saveData() {
    final student = StudentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text,
      email: emailController.text,
      age: int.parse(ageController.text),
    );

    context.read<StudentProvider>().addStudent(student);

    nameController.clear();
    emailController.clear();
    ageController.clear();
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<StudentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Table"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),

            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: "Age",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveData,
              child: const Text("Save"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: StreamBuilder<List<StudentModel>>(
                stream: provider.students,

                builder: (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Data"),
                    );
                  }

                  final students = snapshot.data!;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,

                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Age")),
                        DataColumn(label: Text("Delete")),
                      ],

                      rows: students.map((student) {

                        return DataRow(
                          cells: [

                            DataCell(Text(student.name)),

                            DataCell(Text(student.email)),

                            DataCell(Text(student.age.toString())),

                            DataCell(
                              IconButton(
                                icon: const Icon(Icons.delete),

                                onPressed: () {
                                  provider.deleteStudent(student.id);
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Profile Page")),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Settings Page")),
    );
  }
}

class ProductPage extends StatelessWidget {
  final String productId;
  const ProductPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Product ID: $productId"),
      ),
    );
  }
}