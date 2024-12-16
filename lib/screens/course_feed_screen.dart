import 'package:flutter/material.dart';
import 'package:ppu_feeds/services/api_service.dart';
import 'comments.dart';

class CourseFeedScreen extends StatefulWidget {
  final int courseId;
  final int sectionId;

  CourseFeedScreen({required this.courseId, required this.sectionId});

  @override
  State<CourseFeedScreen> createState() => _CourseFeedScreenState();
}

class _CourseFeedScreenState extends State<CourseFeedScreen> {
  late Future<List<dynamic>> posts;

  @override
  void initState() {
    super.initState();
    posts = ApiService.fetchPosts(widget.courseId, widget.sectionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course Feed')),
      body: FutureBuilder<List<dynamic>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading posts'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post['body']),
                  subtitle: Text("Posted by: ${post['author']}"),
                  trailing: Text(post['date_posted']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Comments(
                          courseId: widget.courseId,
                          sectionId: widget.sectionId,
                          postId: post['id'],
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
