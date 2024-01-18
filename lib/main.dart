import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pagenation_traning/model/book_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    pagenateRefresh();
    controller.addListener(() => _scrollListener());
  }

  Dio dio = Dio();
  List posts = [];
  int page = 1;
  bool isLoading = false;

  final ScrollController controller = ScrollController();
  Future<void> pagenateRefresh() async {
    final String url =
        'https://techcrunch.com/wp-json/wp/v2/posts?context=embed&per_page=10&page=$page';
    print(url);
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      setState(() {
        posts = posts + json;
      });
    } else {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pagenation',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.separated(
          controller: controller,
          separatorBuilder: (context, index) => Divider(),
          itemCount: isLoading ? posts.length + 1 : posts.length,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              final post = posts[index];
              print(index);
              return ListTile(
                title: Text(post['title']['rendered']),
                leading: CircleAvatar(
                  child: Text({index + 1}.toString()),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<void> _scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (isLoading) return;
      setState(() {
        isLoading = true;
      });
      page++;

      await pagenateRefresh();

      setState(() {
        isLoading = false;
      });
    } else {}
  }
}
