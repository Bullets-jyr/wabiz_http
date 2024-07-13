import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wabiz_http/retrofit/post_api.dart';

class RetrofitWidget extends StatefulWidget {
  const RetrofitWidget({super.key});

  @override
  State<RetrofitWidget> createState() => _RetrofitWidgetState();
}

class _RetrofitWidgetState extends State<RetrofitWidget> {
  Dio dio = Dio();
  late PostApi postApi;
  String responseText = '';

  @override
  void initState() {
    // TODO: implement initState
    postApi = PostApi(dio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            postApi.getPosts().then((value) {
              print(value);
              setState(() {
                responseText = value.data.toString();
              });
            });
          },
          child: Text('Retrofit GET'),
        ),
        ElevatedButton(
          onPressed: () {
            postApi.postPosts(
              {
                'title': 'foo',
                'body': 'bar',
                'userId': 1,
              },
            ).then((value) {
              print(value.response.statusCode);
              setState(() {
                responseText = value.data.toString();
              });
            });
          },
          child: Text('Retrofit POST'),
        ),
        ElevatedButton(
          onPressed: () {
            postApi.putPosts(
              '1',
              {
                'title': 'foo',
                'body': 'bar',
                'userId': 1,
              },
            ).then((value) {
              print(value.response.statusCode);
              setState(() {
                responseText = value.data.toString();
              });
            });
          },
          child: Text('Retrofit PUT'),
        ),
        ElevatedButton(
          onPressed: () {
            postApi.deletePosts('1').then((value) {
              print(value.response.statusCode);
              setState(() {
                responseText = value.data.toString();
              });
            });
          },
          child: Text('Retrofit DELETE'),
        ),
        Divider(),
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              responseText,
            ),
          ),
        ),
      ],
    );
  }
}
