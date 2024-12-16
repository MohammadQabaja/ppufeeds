import 'package:flutter/material.dart';
import 'package:testlogin/services/api_service.dart';

class Comments extends StatefulWidget {
  final int courseId;
  final int sectionId;
  final int postId;

  Comments(
      {required this.courseId, required this.sectionId, required this.postId});

  @override
  State<Comments> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<Comments> {
  late Future<List<dynamic>> comments;

  @override
  void initState() {
    super.initState();
    comments = ApiService.fetchComments(
        widget.courseId, widget.sectionId, widget.postId);
  }

  void toggleLike(int commentId) async {
    await ApiService.toggleLike(widget.courseId, widget.sectionId,
        widget.postId, commentId);
    setState(() {
      comments = ApiService.fetchComments(
          widget.courseId, widget.sectionId, widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: FutureBuilder<List<dynamic>>(
        future: comments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading comments'));
          } else {
            final comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment['body']),
                  subtitle: Text("By: ${comment['author']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () => toggleLike(comment['id']),
                      ),
                      Text(comment['likes_count'].toString()),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
