import 'package:flutter/material.dart';
import 'package:votingweb/Pages/Authentication/login.dart';
import 'package:votingweb/Pages/Home/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Voting Web',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Homepage());
  }
}
