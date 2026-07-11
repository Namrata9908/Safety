import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../services/storage_service.dart';
import '../../services/location_service.dart';
import '../../services/sms_service.dart';
import '../../services/map_service.dart';

import '../contacts/contacts_screen.dart';
import '../auth/login_screen.dart';
import '../sos/sos_history_screen.dart';

import '../../theme/app_theme.dart';

import '../../widgets/sos_button.dart';
import '../../widgets/safety_card.dart';
import '../../widgets/safety_tips_card.dart';

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
      final position = await LocationService.getCurrentLocation();

      final response = await ApiService.triggerSOS(
        position.latitude,
        position.longitude,
      );

      final contacts = await ApiService.getContacts();

      List<String> phones = [];

      for (var contact in contacts) {
        phones.add(contact["phone"]);
      }

      String message;

      if (phones.isNotEmpty) {
        await SmsService.sendSOS(phones, position.latitude, position.longitude);

        message = response["message"];
      } else {
        message =
            "SOS Saved Successfully\n"
            "Please add emergency contacts to send SMS alerts";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),

          backgroundColor: AppTheme.danger,

          duration: const Duration(seconds: 4),
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text(
          "Women Safety App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

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
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, AppTheme.secondary],
                ),

                borderRadius: BorderRadius.circular(25),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Welcome 👋",

                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 22,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Stay safe. Your safety is our priority.",

                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // SOS BUTTON UPDATED
            SosButton(
              onPressed: () async {
                await triggerSOS(context);
              },

              onCancel: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("SOS Cancelled"),

                    backgroundColor: Colors.grey,

                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            SafetyCard(
              icon: Icons.contacts,

              title: "Emergency Contacts",

              subtitle: "Manage your trusted contacts",

              color: primaryColor,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (_) => const ContactsScreen()),
                );
              },
            ),

            const SizedBox(height: 15),

            SafetyCard(
              icon: Icons.call,

              title: "Emergency Call",

              subtitle: "Quick access to trusted contacts",

              color: Colors.green,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (_) => const ContactsScreen()),
                );
              },
            ),

            const SizedBox(height: 15),

            SafetyCard(
              icon: Icons.location_on,

              title: "Live Location",

              subtitle: "Tap to view your current location",

              color: Colors.red,

              onTap: () async {
                try {
                  final position = await LocationService.getCurrentLocation();

                  await MapService.openMap(
                    position.latitude,

                    position.longitude,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ),

            const SizedBox(height: 15),

            const SafetyTipsCard(),

            const SizedBox(height: 15),

            SafetyCard(
              icon: Icons.history,

              title: "SOS History",

              subtitle: "View previous SOS alerts",

              color: Colors.redAccent,

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(builder: (_) => const SosHistoryScreen()),
                );
              },
            ),

            const SizedBox(height: 15),

            SafetyCard(
              icon: Icons.local_hospital,

              title: "Nearby Help",

              subtitle: "Find police stations",

              color: Colors.orange,

              onTap: () async {
                try {
                  await MapService.openNearbyPlaces("police station near me");
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
