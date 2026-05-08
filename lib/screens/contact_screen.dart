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
  /// FILTERED CONTACTS
  List<Contact> filteredContacts = [];
  bool isLoading = true;

  /// YOUR MOBILE NUMBER
  final String myNumber = "";

  final TextEditingController searchController =
  TextEditingController();
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
      filteredContacts = contacts;
      print("TOTAL CONTACTS: ${contacts.length}");

    } catch (e) {

      print("CONTACT ERROR: $e");
    }

    setState(() {
      isLoading = false;
    });



  }
  void searchContact(String value) {

    if (value.isEmpty) {

      filteredContacts = contacts;

    } else {

      filteredContacts = contacts.where((contact) {

        final name =
        contact.displayName.toLowerCase();

        final phone = contact.phones.isNotEmpty
            ? contact.phones.first.number
            : "";

        return name.contains(
          value.toLowerCase(),
        ) ||
            phone.contains(value);

      }).toList();
    }

    setState(() {});
  }
// SEARCH CONTACT

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

      body:  isLoading

          ? const Center(
        child: CircularProgressIndicator(),
      )

          : Column(
        children: [

          /// SEARCH BOX
          Padding(
            padding: const EdgeInsets.all(10),

            child: TextField(

              controller: searchController,

              onChanged: searchContact,

              decoration: InputDecoration(

                hintText: "Search contact",

                prefixIcon:
                const Icon(Icons.search),

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          /// CONTACT LIST
          Expanded(
            child: filteredContacts.isEmpty

                ? const Center(
              child: Text(
                "No Contact Found",
              ),
            )

                : ListView.builder(

              itemCount:
              filteredContacts.length,

              itemBuilder:
                  (context, index) {

                final contact =
                filteredContacts[index];

                String phone = "";

                if (contact
                    .phones.isNotEmpty) {

                  phone = cleanNumber(
                    contact
                        .phones
                        .first
                        .number,
                  );
                }

                return ListTile(

                  leading: CircleAvatar(
                    child: Text(

                      contact.displayName
                          .isNotEmpty

                          ? contact
                          .displayName[0]

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

                  onTap: phone.isEmpty
                      ? null
                      : () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            ChatScreen(

                              senderId:
                              widget.senderId,

                              receiverId:
                              phone,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}