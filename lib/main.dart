import 'package:flutter/material.dart';
import 'UI/Admin/Home.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AdminHome.route:(context)=>AdminHome()
      },
      debugShowCheckedModeBanner: false,
      home: AdminHome(),
    );
  }
}
