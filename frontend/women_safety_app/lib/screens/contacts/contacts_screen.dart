import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../services/call_service.dart';

import 'add_contact_screen.dart';
import 'edit_contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List contacts = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadContacts();
  }

  Future<void> loadContacts() async {
    try {
      final data = await ApiService.getContacts();

      if (!mounted) return;

      setState(() {
        contacts = data;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      final response = await ApiService.deleteContact(id);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response["message"])));

      loadContacts();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Emergency Contacts",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        backgroundColor: primaryColor,

        centerTitle: true,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : contacts.isEmpty
          ? const Center(
              child: Text(
                "No Contacts Found",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 90, top: 10),

              itemCount: contacts.length,

              itemBuilder: (context, index) {
                final contact = contacts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),

                  elevation: 4,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(15),

                    child: Row(
                      children: [
                        // Profile Icon
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: primaryColor,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),

                        const SizedBox(width: 15),

                        // Contact Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                contact["name"],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                contact["phone"],
                                style: const TextStyle(fontSize: 16),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                "Relationship: ${contact["relationship"]}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),

                        // Icons
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.call, color: Colors.green),

                              onPressed: () async {
                                await CallService.makeCall(contact["phone"]);
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),

                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EditContactScreen(contact: contact),
                                  ),
                                );

                                if (result == true) {
                                  loadContacts();
                                }
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),

                              onPressed: () {
                                showDialog(
                                  context: context,

                                  builder: (context) => AlertDialog(
                                    title: const Text("Delete Contact"),

                                    content: const Text(
                                      "Are you sure you want to delete this contact?",
                                    ),

                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },

                                        child: const Text("Cancel"),
                                      ),

                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),

                                        onPressed: () async {
                                          Navigator.pop(context);

                                          await deleteContact(contact["_id"]);
                                        },

                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );git 
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,

        onPressed: () async {
          await Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const AddContactScreen()),
          );

          loadContacts();
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
