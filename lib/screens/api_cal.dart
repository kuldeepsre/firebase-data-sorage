import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/ApiProvider.dart';

class APICallScreen extends StatefulWidget {

  const APICallScreen({super.key});

  @override
  State<APICallScreen> createState() =>
      _APICallScreenState();
}

class _APICallScreenState
    extends State<APICallScreen> {

  final TextEditingController
  nameController =
  TextEditingController();

  final TextEditingController
  emailController =
  TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'POST API Provider',
        ),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            TextField(
              controller: nameController,
              decoration:
              const InputDecoration(
                labelText: 'Name',
              ),
            ),

            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration:
              const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 30),
            provider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                provider.postData(
                  name:
                  nameController.text,
                  email:
                  emailController.text,
                );
              },
              child: const Text(
                'Submit',
              ),
            ),
            const SizedBox(height: 30),
            Text(
              provider.result,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}