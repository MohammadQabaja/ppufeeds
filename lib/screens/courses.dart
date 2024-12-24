import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ppu_feeds/models/course.dart';

class CoursesScreen extends StatefulWidget {
  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Course> cource = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCourses();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Courses"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: cource.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  cource[index].name,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              );
            },
          ),
        ));
  }

  String url = "http://feeds.ppu.edu/api/v1/courses";
  Future<void> getCourses() async {
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Authorization":
            "998449f4b01af6841aa60957434840987287d824e02bdea308529abb7e86f14c"
      });

      final res = jsonDecode(response.body)["courses"] as List;
      cource = res
          .map(
            (e) => Course.fromJson(e),
          )
          .toList();
      print(cource);
    } catch (err) {
      print("err :  $err");
    }
  }
}
