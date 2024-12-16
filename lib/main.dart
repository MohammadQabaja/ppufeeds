import 'package:flutter/material.dart';
import 'package:testlogin/screens/loginpage.dart';
import 'package:testlogin/screens/home.dart';
import 'package:testlogin/screens/courses.dart';
import 'package:testlogin/screens/feeds.dart';
import 'package:testlogin/screens/course_feed_screen.dart';
import 'package:testlogin/screens/comments.dart'; // Import Comments screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login', // Starting at LoginPage
      routes: {
        '/': (context) => LoginPage(), // Login screen as the root
        '/home': (context) => HomeScreen(), // Home screen
        '/courses': (context) => CoursesScreen(), // Courses screen
        '/feeds': (context) => FeedsScreen(), // Feeds screen
        '/courseFeed': (context) => CourseFeedScreen(
              courseId: 1, // Replace with dynamic value if needed
              sectionId: 1, // Replace with dynamic value if needed
            ),
        '/comments': (context) => Comments(
              courseId: 1, // Replace with dynamic values if needed
              sectionId: 1, // Replace with dynamic values if needed
              postId: 1, // Replace with dynamic values if needed
            ),
      },
    );
  }
}
