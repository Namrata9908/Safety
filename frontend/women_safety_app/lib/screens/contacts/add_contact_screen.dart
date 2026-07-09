import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController relationshipController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();

    phoneController.dispose();

    relationshipController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Emergency Contact"),

        backgroundColor: primaryColor,

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: nameController,

              decoration: const InputDecoration(
                labelText: "Name",

                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: phoneController,

              keyboardType: TextInputType.phone,

              decoration: const InputDecoration(
                labelText: "Phone Number",

                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: relationshipController,

              decoration: const InputDecoration(
                labelText: "Relationship",

                prefixIcon: Icon(Icons.family_restroom),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: () async {
                  final response = await ApiService.addContact(
                    nameController.text,

                    phoneController.text,

                    relationshipController.text,
                  );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(response["message"])));

                  if (response["message"] ==
                      "Emergency Contact Added Successfully") {
                    Navigator.pop(context);
                  }
                },

                child: const Text(
                  "Save Contact",

                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
