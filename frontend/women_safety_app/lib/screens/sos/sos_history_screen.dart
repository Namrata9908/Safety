import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../services/map_service.dart';

class SosHistoryScreen extends StatefulWidget {
  const SosHistoryScreen({super.key});
  @override
  State<SosHistoryScreen> createState() => _SosHistoryScreenState();
}

class _SosHistoryScreenState extends State<SosHistoryScreen> {
  List sosHistory = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadSOSHistory();
  }

  Future<void> loadSOSHistory() async {
    try {
      final data = await ApiService.getSOSHistory();
      setState(() {
        sosHistory = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date).toLocal();

    int hour = parsedDate.hour;

    String period = hour >= 12 ? "PM" : "AM";

    hour = hour % 12;

    if (hour == 0) {
      hour = 12;
    }

    String minute = parsedDate.minute.toString().padLeft(2, '0');

    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year} "
        "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SOS History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : sosHistory.isEmpty
          ? const Center(
              child: Text(
                "No SOS History Found",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: sosHistory.length,
              itemBuilder: (context, index) {
                final sos = sosHistory[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.warning,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Text(
                              "SOS Alert",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Latitude : ${sos["latitude"]}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Longitude : ${sos["longitude"]}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Status : ${sos["status"]}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Date : ${formatDate(sos["createdAt"])}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            try {
                              await MapService.openMap(
                                sos["latitude"],
                                sos["longitude"],
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                          icon: const Icon(Icons.location_on),
                          label: const Text("View Location"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
