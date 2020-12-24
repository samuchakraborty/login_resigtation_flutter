import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ElementOtp> createElement(String mobile, String otp) async {
  final http.Response response = await http.post(
    'https://anazbd.com/api/register',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"mobile": mobile, "otp": otp}),
  );
  var res = jsonDecode(response.body);

  print(res["data"]["token"]);

  //  return res["status"];
  // return jsonDecode(response.body);

  if (res["status"] == "success") {
    //return Text("sucess");

    print(res["data"]["token"]);
    // return ElementOtp.fromJson(jsonDecode(response.body));
    return res["data"].token;
  } else {
    throw Exception('Failed to create Element.');
  }
}

class ElementOtp {
  final String mobile;
  final String otp;

  ElementOtp({this.mobile, this.otp});

  factory ElementOtp.fromJson(Map<String, dynamic> json) {
    return ElementOtp(
      mobile: json['mobile'],
      otp: json['otp'],
    );
  }
}

class OtpPage extends StatelessWidget {
  final mobileHolder;

  final otp = TextEditingController();
  OtpPage({
    this.mobileHolder,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hello")),
      body: Container(
        child: Column(children: [
          Visibility(
            visible: true,
            child: Text("mobile: " + mobileHolder),
          ),
          TextField(
            controller: otp,
            decoration: InputDecoration(hintText: 'Enter Otp'),
          ),
          ElevatedButton(
            child: Text('Create Data'),
            onPressed: () {
              // setState(() {
              createElement(mobileHolder, otp.text);
              //  print(_mobileController.text);

              //});
            },
          ),
        ]),
      ),
    );
  }
}
