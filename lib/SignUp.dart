import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_resigter/otpPage.dart';

Future<Element> createElement(
    String mobile, String name, String password) async {
  final http.Response response = await http.post(
    'https://anazbd.com/api/send/otp',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{"mobile": mobile, "name": name, "password": password}),
  );
  var res = jsonDecode(response.body);

  print(res["status"]);

//  return res["status"];
  // return jsonDecode(response.body);

  if (res["status"] == "success") {
//return Text("sucess");
    return Element.fromJson(
      jsonDecode(
response.body));
  } else {
    throw Exception('Failed to create Element.');
  }

  // if (response.statusCode == 201) {
  //   //return Element.fromJson(jsonDecode(response.body));

  //   return jsonDecode(response.body);

  // } else {
  //   throw Exception('Failed to create Element.' + response.statusCode.toString());
  // }
}

class Element {
  final String mobile;
  final String name;
  final String password;

  Element({this.mobile, this.password, this.name});

  factory Element.fromJson(Map<String, dynamic> json) {
    return Element(
      mobile: json['mobile'],
      password: json['password'],
      name: json['name'],
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final mobile = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();

  // Future<Element> _futureElement;

  // getItemAndNavigate(context);

  getItemAndNavigate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpPage(
                  mobileHolder: mobile.text,
                  // emailHolder: mobile.text,
                  // passwordHolder: password.text,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Data Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TextFormField(
            //   decoration: const InputDecoration(
            //     icon: Icon(Icons.email),
            //     border: InputBorder.none,
            //     hintText: "Enter mobile Number/ Email",
            //   ),
            //   onSaved: (String value) {
            //     // This optional block of code can be used to run
            //     // code when the user saves the form.
            //   },
            //   validator: (String value) {
            //     return value.contains('@')
            //         ? null
            //         : 'Do not use the @ char.';
            //   },
            // ),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     border: InputBorder.none,
            //     icon: Icon(Icons.people),
            //     hintText: "Enter Your Name",
            //   ),
            //   onSaved: (String value) {
            //     // This optional block of code can be used to run
            //     // code when the user saves the form.
            //   },
            //   validator: (String value) {
            //     return value.contains('@')
            //         ? 'Do not use the @ char.'
            //         : null;
            //   },
            // ),
            // TextFormField(
            //   decoration: const InputDecoration(
            //     border: InputBorder.none,
            //     icon: Icon(Icons.lock),
            //     hintText: "Enter Your Password",
            //   ),
            //   onSaved: (String value) {
            //     // This optional block of code can be used to run
            //     // code when the user saves the form.
            //   },
            //   validator: (String value) {
            //     //  return value.contains('@') ? null : 'Do not use the @ char.';
            //     return value.length < 4
            //         ? "Password too short"
            //         : "Enter a password";
            //   },
            //   obscureText: true,
            // ),
            TextField(
              controller: mobile,
              decoration: InputDecoration(hintText: 'Enter Mobile'),
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Enter Name'),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: 'Enter Passwrod'),
            ),

            ElevatedButton(
              child: Text('Create Data'),
              onPressed: () {
                // setState(() {
                createElement(mobile.text, name.text, password.text);

                getItemAndNavigate(context);
                //});
              },
            ),
          ],
        ),
      ),
    );
  }
}
