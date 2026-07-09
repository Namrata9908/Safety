import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class EditContactScreen extends StatefulWidget {
  final Map<String, dynamic> contact;

  const EditContactScreen({
    super.key,
    required this.contact,
  });

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController relationshipController;


  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.contact["name"]);

    phoneController =
        TextEditingController(text: widget.contact["phone"]);

    relationshipController =
        TextEditingController(
          text: widget.contact["relationship"],
        );
  }


  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    relationshipController.dispose();

    super.dispose();
  }


  Future<void> updateContact() async {

    final response = await ApiService.updateContact(
      widget.contact["_id"],
      nameController.text.trim(),
      phoneController.text.trim(),
      relationshipController.text.trim(),
    );


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response["message"]),
      ),
    );


    if(response["message"] == "Contact Updated Successfully"){

      Navigator.pop(context,true);

    }

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text("Edit Contact"),

        backgroundColor:
            Theme.of(context).colorScheme.primary,

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


            const SizedBox(height:20),



            TextField(

              controller: phoneController,

              keyboardType: TextInputType.phone,

              decoration: const InputDecoration(

                labelText: "Phone Number",

                prefixIcon: Icon(Icons.phone),

              ),

            ),



            const SizedBox(height:20),



            TextField(

              controller: relationshipController,

              decoration: const InputDecoration(

                labelText: "Relationship",

                prefixIcon: Icon(Icons.family_restroom),

              ),

            ),



            const SizedBox(height:30),



            SizedBox(

              width: double.infinity,


              child: ElevatedButton(


                onPressed: updateContact,


                style: ElevatedButton.styleFrom(

                  backgroundColor:
                      Theme.of(context)
                          .colorScheme
                          .primary,

                  foregroundColor: Colors.white,


                  padding:
                      const EdgeInsets.symmetric(
                        vertical:15,
                      ),

                ),


                child: const Text(

                  "Update Contact",

                  style: TextStyle(
                    fontSize:18,
                  ),

                ),

              ),

            ),


          ],

        ),

      ),

    );

  }

}