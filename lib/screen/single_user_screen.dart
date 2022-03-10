import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter_dio/http_service.dart';
import 'package:learn_flutter_dio/model/single_user_response.dart';
import 'package:learn_flutter_dio/model/user.dart';

class SingleUserScreen extends StatefulWidget {
  const SingleUserScreen({Key? key}) : super(key: key);

  @override
  State<SingleUserScreen> createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  late HttpService http;
  late SingleUserResponse singleUserResponse;
  late User user;
  bool isLoading = false;
  Future getUser() async {
    Response response;
    try {
      isLoading = true;
      response = await http.getRequest("/api/users/2");
      isLoading = false;
      if (response.statusCode == 200) {
        setState(() {
          singleUserResponse = SingleUserResponse.fromJson(response.data);
          user = singleUserResponse.user;
        });
      } else {
        log('There is an error');
        throw Exception('Failed to load post');
      }
    } on Exception catch (e) {
      isLoading = false;
      log(e.toString());
    }
  }

  @override
  void initState() {
    http = HttpService();
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single User'),
      ),
      body: Center(
        child: isLoading
            ? const Text('loading...')
            : Column(
                children: [
                  Image.network(user.avatar),
                  Text('Hello, ${user.firstName}'),
                ],
              ),
      ),
    );
  }
}
