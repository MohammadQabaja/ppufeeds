import 'package:flutter/material.dart';
import 'package:ppu_feeds/screens/course_feed_screen.dart';
import 'package:ppu_feeds/screens/courses.dart';
import 'package:ppu_feeds/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> subscriptions;

  @override
  void initState() {
    super.initState();
    subscriptions = ApiService.fetchSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscribed Courses'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CoursesScreen()));
              },
              icon: Icon(Icons.list))
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: subscriptions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading subscriptions'));
          } else {
            final subs = snapshot.data!;
            return ListView.builder(
              itemCount: subs.length,
              itemBuilder: (context, index) {
                final sub = subs[index];
                return ListTile(
                  title: Text(sub['course']),
                  subtitle: Text("Section: ${sub['section']}"),
                  trailing: Text(sub['lecturer']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseFeedScreen(
                          courseId: sub['id'],
                          sectionId: sub['section_id'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
