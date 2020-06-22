import 'package:ecom_front_end/UI/Customer/Cart/CartHome.dart';
import 'package:ecom_front_end/UI/Customer/Home.dart';
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
        AdminHome.route:(context)=>AdminHome(),
        CustomerHome.route:(context)=>CustomerHome(),
        CartHome.route:(context)=>CartHome()
      },
      debugShowCheckedModeBanner: false,
      home:AdminHome(),
    );
  }
}
