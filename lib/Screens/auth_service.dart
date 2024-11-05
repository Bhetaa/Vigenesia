import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vigenesia/Models/UserModel.dart';

class AuthService {
  // URL endpoint server for registration
  final String registerUrl = "http://192.168.1.6/vigenesia/register.php"; // Update to your server's address

  Future<bool> registerUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()), // Use the User model to convert to JSON
      );

      return response.statusCode == 201;  // Check if registration is successful
    } catch (e) {
      print("Error: $e");
      return false;  // Return false if an error occurs
    }
  }
}
