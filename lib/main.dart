import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> createAlbum(String mobile, String name, String password) async {
  final http.Response response = await http.post(
    'https://anazbd.com/api/send/otp',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{"mobile": mobile, "name": name, "password": password}),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.' + response.statusCode.toString());
  }
}

class Album {
  final String mobile;
  final String name;
  final String password;

  Album({this.mobile, this.password, this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      mobile: json['mobile'],
      password: json['password'],
      name: json['name'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<Album> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null)
              ? Column(
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
                      controller: _mobileController,
                      decoration: InputDecoration(hintText: 'Enter Mobile'),
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: 'Enter Name'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: 'Enter Passwrod'),
                    ),

                    ElevatedButton(
                      child: Text('Create Data'),
                      onPressed: () {
                        setState(() {
                          _futureAlbum = createAlbum(_mobileController.text,
                              _nameController.text, _passwordController.text);
                          print(_mobileController.text);
                        });
                      },
                    ),
                  ],
                )
              : FutureBuilder<Album>(
                  future: _futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text("hello")
                          // Text(snapshot.data.name),
                          // Text(snapshot.data.mobile.toString()),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}
