import 'package:flutter/material.dart';
import 'package:ppu_feeds/services/api_service.dart';

class FeedsScreen extends StatefulWidget {
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  late Future<List<dynamic>> courses;

  @override
  void initState() {
    super.initState();
    courses = ApiService.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feeds')),
      body: FutureBuilder<List<dynamic>>(
        future: courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading courses'));
          } else {
            final courses = snapshot.data!;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return ListTile(
                  title: Text(course['name']),
                  subtitle: Text(course['college']),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to course details
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
