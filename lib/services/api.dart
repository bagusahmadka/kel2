import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static const String baseUrl = 'http://192.168.1.7:8000/api'; // Update to your server address
  String? _token;

  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      print("Attempting to register...");
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      ).timeout(const Duration(seconds: 10)); // Set timeout for requests

      print("Register response status: ${response.statusCode}");
      print("Register response body: ${response.body}");
      
      return _handleResponse(response);
    } catch (e) {
    
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print("Attempting to login...");
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10)); // Set timeout for requests

      print("Login response status: ${response.statusCode}");
      print("Login response body: ${response.body}");

      final result = _handleResponse(response);
      if (result.containsKey('token')) {
        await setToken(result['token']); // Save the token if login is successful
      }
      return result;
    } catch (e) {
      print("Failed to connect to login: $e");
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    await loadToken();
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    try {
      print("Attempting to get profile...");
      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      ).timeout(const Duration(seconds: 10)); // Set timeout for requests

      print("Profile response status: ${response.statusCode}");
      print("Profile response body: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("Failed to connect to get profile: $e");
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    try {
      print("Attempting to logout...");
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      ).timeout(const Duration(seconds: 10)); // Set timeout for requests

      await clearToken(); // Clear token on logout
      print("Logout response status: ${response.statusCode}");
      print("Logout response body: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("Failed to connect to logout: $e");
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    if (_token == null) {
      return {'message': 'User is not logged in.'};
    }

    try {
      print("Attempting to delete account...");
      final response = await http.delete(
        Uri.parse('$baseUrl/delete-account'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      ).timeout(const Duration(seconds: 10)); // Set timeout for requests

      await clearToken(); // Clear token if account deletion is successful
      print("Delete account response status: ${response.statusCode}");
      print("Delete account response body: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("Failed to connect to delete account: $e");
      return {'message': 'Failed to connect to the server: $e'};
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    try {
      print("Attempting to resend verification email...");
      final response = await http.post(
        Uri.parse('$baseUrl/resend-verification-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      ).timeout(const Duration(seconds: 10)); // Set timeout for requests

      print("Resend verification response status: ${response.statusCode}");
      print("Resend verification response body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception('Failed to send verification email: ${response.body}');
      }
    } catch (e) {
      print("Failed to connect to resend verification email: $e");
      throw Exception('Failed to connect to the server: $e');
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final responseBody = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody; // Successful response
      } else {
        return {
          'message': responseBody['message'] ?? 'Unknown error occurred',
          'status_code': response.statusCode
        };
      }
    } catch (e) {
      return {
        'message': 'Failed to parse server response',
        'status_code': response.statusCode
      };
    }
  }
}
