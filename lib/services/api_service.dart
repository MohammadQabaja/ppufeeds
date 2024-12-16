import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://feeds.ppu.edu/api/v1";

  // User login
  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['session_token']);
      return data['session_token'];
    } else {
      return null;
    }
  }

  // Fetch list of courses
  static Future<List<dynamic>> fetchCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse("$baseUrl/courses"),
      headers: {"Authorization": token ?? ""},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['courses'];
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Fetch subscribed courses
  static Future<List<dynamic>> fetchSubscriptions() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse("$baseUrl/subscriptions");

    final response = await http.get(
      url,
      headers: {"Authorization": token ?? ""},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['subscriptions'];
    } else {
      throw Exception('Failed to load subscriptions');
    }
  }

  // Fetch posts for a specific course and section
  static Future<List<dynamic>> fetchPosts(int courseId, int sectionId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url =
        Uri.parse("$baseUrl/courses/$courseId/sections/$sectionId/posts");

    final response = await http.get(
      url,
      headers: {"Authorization": token ?? ""},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['posts'];
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // Fetch comments for a specific post
  static Future<List<dynamic>> fetchComments(
      int courseId, int sectionId, int postId) async {
    final url = Uri.parse(
        '$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load comments');
    }
  }

  // Toggle like for a comment
  static Future<void> toggleLike(
      int courseId, int sectionId, int postId, int commentId) async {
    final url = Uri.parse(
        '$baseUrl/courses/$courseId/sections/$sectionId/posts/$postId/comments/$commentId/like');

    final response = await http.post(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle like');
    }
  }
}
