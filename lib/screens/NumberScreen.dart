import 'package:dpl/screens/contact_screen.dart';
import 'package:flutter/material.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() =>
      _NumberScreenState();
}

class _NumberScreenState
    extends State<NumberScreen> {

  final TextEditingController controller =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Enter Number"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: controller,

              keyboardType:
              TextInputType.phone,

              decoration:
              const InputDecoration(
                hintText: "Enter mobile number",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: () {

                String myNumber =
                controller.text.trim();

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => ContactScreen(

                      /// MY NUMBER
                      senderId: myNumber,


                    ),
                  ),
                );
              },

              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}