import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

import 'chat_screeen.dart';

class ContactScreen extends StatefulWidget {
  final String senderId;
  const ContactScreen({super.key, required this.senderId});

  @override
  State<ContactScreen> createState() =>
      _ContactScreenState();
}

class _ContactScreenState
    extends State<ContactScreen> {

  List<Contact> contacts = [];

  bool isLoading = true;

  /// YOUR MOBILE NUMBER
  final String myNumber = "";

  @override
  void initState() {
    super.initState();

    loadContacts();
  }

  /// LOAD CONTACTS
  Future<void> loadContacts() async {

    try {

      contacts =
      await FastContacts.getAllContacts();

      print("TOTAL CONTACTS: ${contacts.length}");

    } catch (e) {

      print("CONTACT ERROR: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  /// CLEAN PHONE NUMBER
  String cleanNumber(String number) {

    return number
        .replaceAll(" ", "")
        .replaceAll("-", "")
        .replaceAll("(", "")
        .replaceAll(")", "");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Contacts"),
      ),

      body: isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : contacts.isEmpty

          ? const Center(
        child: Text("No Contacts Found"),
      )

          : ListView.builder(

        itemCount: contacts.length,

        itemBuilder: (context, index) {

          final contact = contacts[index];

          /// GET NUMBER
          String phone = "";

          if (contact.phones.isNotEmpty) {

            phone = cleanNumber(
              contact.phones.first.number,
            );
          }

          return ListTile(

            leading: CircleAvatar(
              child: Text(
                contact.displayName.isNotEmpty
                    ? contact.displayName[0]
                    : "?",
              ),
            ),

            title: Text(
              contact.displayName,
            ),

            subtitle: Text(
              phone.isEmpty
                  ? "No Number"
                  : phone,
            ),

            /// OPEN CHAT
            onTap: phone.isEmpty
                ? null
                : () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder: (_) => ChatScreen(

                    /// MY NUMBER
                    senderId: widget.senderId,

                    /// CONTACT NUMBER
                    receiverId: phone,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}