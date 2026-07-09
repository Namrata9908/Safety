import 'package:flutter/material.dart';

class SafetyTipsCard extends StatelessWidget {
  const SafetyTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: Colors.orange,

                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Icon(Icons.shield, color: Colors.white),
                ),

                const SizedBox(width: 15),

                const Text(
                  "Safety Tips",

                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 15),

            const Text(
              "• Keep emergency contacts updated\n\n"
              "• Share your location when travelling\n\n"
              "• Stay aware of your surroundings",

              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
