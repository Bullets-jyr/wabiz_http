import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class HttpWidget extends StatefulWidget {
  const HttpWidget({super.key});

  @override
  State<HttpWidget> createState() => _HttpWidgetState();
}

class _HttpWidgetState extends State<HttpWidget> {
  String responseText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            final response = await http.get(Uri.parse(api));
            if (response.statusCode == 200) {
              setState(() {
                responseText = response.body;
              });
            }
          },
          child: Text(
            'Http Get',
          ),
        ),
        TextButton(
          onPressed: () async {
            final response = await http.post(
              Uri.parse(api),
              headers: {
                'content-type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode(
                {
                  'title': 'foo',
                  'body': 'bar',
                  'userId': 1,
                },
              ),
            );
            print(response.statusCode);
            if (response.statusCode == 201) {
              setState(() {
                responseText = response.body;
              });
            }
          },
          child: Text(
            'Http Post',
          ),
        ),
        TextButton(
          onPressed: () {
            http.put(
              Uri.parse('$api/1'),
              headers: {
                'content-type': 'application/json; charset=UTF-8'
              },
              body: jsonEncode(
                {
                  'title': 'foo',
                  'body': 'bar',
                  'userId': 1,
                },
              ),
            ).then((value) {
              print(value.statusCode);
              setState(() {
                responseText = value.body;
              });
            });
          },
          child: Text(
            'Http Put',
          ),
        ),
        TextButton(
          onPressed: () {
            http.delete(
              Uri.parse('$api/1'),
              // headers: {
              //   'content-type': 'application/json; charset=UTF-8'
              // },
              // body: jsonEncode(
              //   {
              //     'title': 'foo',
              //     'body': 'bar',
              //     'userId': 1,
              //   },
              // ),
            ).then((response) {
              print(response.statusCode);
              if (response.statusCode == 200) {
                setState(() {
                  responseText = response.body;
                });
              }
            });
          },
          child: Text(
            'Http Delete',
          ),
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
