import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              getCourses();
            },
            child: Text("get courses")),
      ),
    );
  }
}

String url = "http://feeds.ppu.edu/api/v1/courses";
Future<void> getCourses() async {
  http.Response response = await http
      .get(Uri.parse(url), headers: {"Authorization": "sdfdsfdsfdsfsdfsdf"});

  print(response.statusCode);
  print(response.body);
}
