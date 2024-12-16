import 'package:flutter/material.dart';
import 'package:ppu_feeds/screens/loginpage.dart';
import 'package:ppu_feeds/screens/home.dart';
import 'package:ppu_feeds/screens/courses.dart';
import 'package:ppu_feeds/screens/feeds.dart';
import 'package:ppu_feeds/screens/course_feed_screen.dart';
import 'package:ppu_feeds/screens/comments.dart'; 

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
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(), // Login screen as the root
        '/home': (context) => HomeScreen(), 
        '/courses': (context) => CoursesScreen(), 
        '/feeds': (context) => FeedsScreen(), 
        '/courseFeed': (context) => CourseFeedScreen(
              courseId: 1, 
              sectionId: 1, 
            ),
        '/comments': (context) => Comments(
              courseId: 1, 
              sectionId: 1,
              postId: 1, 
            ),
      },
    );
  }
}
