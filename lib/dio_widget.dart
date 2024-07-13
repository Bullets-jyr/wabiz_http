import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'main.dart';

class DioWidget extends StatefulWidget {
  const DioWidget({super.key});

  @override
  State<DioWidget> createState() => _DioWidgetState();
}

class _DioWidgetState extends State<DioWidget> {
  String responseText = '';

  Dio dio = Dio(
    BaseOptions(
      headers: {
        'content-type': 'application/json; charset=UTF-8',
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            dio.get(api).then(
              (value) {
                print(value.data);
                setState(() {
                  responseText = value.data.toString();
                });
              },
            );
          },
          child: Text('Dio GET'),
        ),
        TextButton(
          onPressed: () {
            dio.post(
              api,
              // options: Options(
              //   headers: {
              //     'content-type': 'application/json; charset=UTF-8',
              //   },
              // ),
              data: {
                'title': 'foo',
                'body': 'bar',
                'userId': 1,
              },
            ).then(
              (response) {
                print(response.statusCode);
                setState(() {
                  responseText = response.data.toString();
                });
              },
            );
          },
          child: Text('Dio POST'),
        ),
        TextButton(
          onPressed: () {
            dio.putUri(
              Uri.parse('$api/1'),
              // options: Options(
              //   headers: {
              //     'content-type': 'application/json; charset=UTF-8',
              //   },
              // ),
              data: {
                'title': 'foo',
                'body': 'bar',
                'userId': 1,
              },
            ).then(
              (value) {
                print(value.statusCode);
                setState(() {
                  responseText = value.data.toString();
                });
              },
            );
          },
          child: Text('Dio PUT'),
        ),
        TextButton(
          onPressed: () {
            try {
              dio.delete('$api/1');
            } on DioException catch (error) {
              print(error.toString());
            }
          },
          child: Text('Dio DELETE'),
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
