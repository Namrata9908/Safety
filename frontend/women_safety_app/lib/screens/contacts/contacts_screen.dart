import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'add_contact_screen.dart';
import 'edit_contact_screen.dart';
import '../../services/call_service.dart';

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

      setState(() {
        contacts = data;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> deleteContact(String id) async {
    final response = await ApiService.deleteContact(id);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(response["message"])));

    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Contacts"),

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
              padding: const EdgeInsets.only(bottom: 90),

              itemCount: contacts.length,

              itemBuilder: (context, index) {
                final contact = contacts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,

                    vertical: 8,
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: primaryColor,

                      child: const Icon(Icons.person, color: Colors.white),
                    ),

                    title: Text(
                      contact["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        SizedBox(
                          width: 160,
                          child: Text(
                            contact["phone"],
                            style: const TextStyle(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Text("Relationship: ${contact["relationship"]}"),
                      ],
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [
                        IconButton(
                          icon: const Icon(Icons.call, color: Colors.green),

                          onPressed: () async {
                            try {
                              await CallService.makeCall(contact["phone"]);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
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
                  ),
                );
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
