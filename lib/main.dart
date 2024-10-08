import 'package:boko_test/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAuthenticated = false;
  String? accessToken;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child:
              // isAuthenticated
              //     ?
              HomePage()
          // :
          //     ElevatedButton(
          //   onPressed: authenticate,
          //   child: const Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Text("Login with Keycloak"),
          //   ),
          // ),
          ),
    );
  }
}
