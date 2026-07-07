import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../contacts/contacts_screen.dart';
import '../auth/login_screen.dart';
import '../../services/storage_service.dart';
import '../../services/location_service.dart';
import '../../services/sms_service.dart';
import '../../services/map_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await StorageService.removeToken();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Future<void> triggerSOS(BuildContext context) async {
    try {
      // Get current location
      final position = await LocationService.getCurrentLocation();

      // Save SOS in MongoDB
      final response = await ApiService.triggerSOS(
        position.latitude,
        position.longitude,
      );

      // Get emergency contacts
      final contacts = await ApiService.getContacts();

      // Extract phone numbers
      List<String> phones = [];

      for (var contact in contacts) {
        phones.add(contact["phone"]);
      }

      // Open SMS app
      if (phones.isNotEmpty) {
        await SmsService.sendSOS(phones, position.latitude, position.longitude);
      }

      // Open Google Maps
      await MapService.openMap(position.latitude, position.longitude);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response["message"]),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Women Safety App"),
        backgroundColor: Colors.pink,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              "Welcome to Women Safety App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => triggerSOS(context),
                icon: const Icon(Icons.warning, size: 30),
                label: const Text(
                  "TRIGGER SOS",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ContactsScreen()),
                  );
                },
                icon: const Icon(Icons.contacts),
                label: const Text(
                  "Emergency Contacts",
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
