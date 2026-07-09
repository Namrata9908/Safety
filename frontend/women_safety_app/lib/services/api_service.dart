import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class ApiService {
  static const String baseUrl = "http://192.168.0.107:5000/api";

  // LOGIN API
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users/login"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({"email": email, "password": password}),
    );

    return jsonDecode(response.body);
  }

  // ADD CONTACT API
  static Future<Map<String, dynamic>> addContact(
    String name,
    String phone,
    String relationship,
  ) async {
    String? token = await StorageService.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/contacts"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "name": name,
        "phone": phone,
        "relationship": relationship,
      }),
    );

    return jsonDecode(response.body);
  }

  // GET CONTACTS API
  static Future<List<dynamic>> getContacts() async {
    String? token = await StorageService.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/contacts"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  }

  // DELETE CONTACT API
  static Future<Map<String, dynamic>> deleteContact(String id) async {
    String? token = await StorageService.getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl/contacts/$id"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },
    );

    return jsonDecode(response.body);
  }

  // UPDATE CONTACT API
  static Future<Map<String, dynamic>> updateContact(
    String id,

    String name,

    String phone,

    String relationship,
  ) async {
    String? token = await StorageService.getToken();

    final response = await http.put(
      Uri.parse("$baseUrl/contacts/$id"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "name": name,

        "phone": phone,

        "relationship": relationship,
      }),
    );

    return jsonDecode(response.body);
  }

  // TRIGGER SOS API
  static Future<Map<String, dynamic>> triggerSOS(
    double latitude,

    double longitude,
  ) async {
    String? token = await StorageService.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/sos"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },

      body: jsonEncode({"latitude": latitude, "longitude": longitude}),
    );

    return jsonDecode(response.body);
  }

  // GET SOS HISTORY API
  static Future<List<dynamic>> getSOSHistory() async {
    String? token = await StorageService.getToken();

    if (token == null) {
      throw Exception("User not logged in");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/sos/history"),

      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("SOS HISTORY STATUS : ${response.statusCode}");
    print("SOS HISTORY DATA : ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return List<dynamic>.from(data);
    } else {
      throw Exception("Failed to load SOS History ${response.statusCode}");
    }
  }

  // RESOLVE SOS API
  static Future<Map<String, dynamic>> resolveSOS(String id) async {
    String? token = await StorageService.getToken();

    final response = await http.put(
      Uri.parse("$baseUrl/sos/$id/resolve"),

      headers: {
        "Content-Type": "application/json",

        "Authorization": "Bearer $token",
      },
    );

    print("RESOLVE STATUS : ${response.statusCode}");
    print("RESOLVE DATA : ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to resolve SOS");
    }
  }
}
