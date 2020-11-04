import 'package:sharestapp/mytabview.dart';
import 'package:flutter/material.dart';
import 'package:sharestapp/aboutus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTabView(),
      routes: {
        '/aboutus': (context) => AboutUs(),
      },
    );
  }
}
