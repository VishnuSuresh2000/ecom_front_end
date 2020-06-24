import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:ecom_front_end/UI/Customer/Home.dart';
import 'package:ecom_front_end/UI/Seller/home.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SwitchHome extends StatefulWidget {
  static String route="switchHome";
  @override
  _SwitchHomeState createState() => _SwitchHomeState();
}

class _SwitchHomeState extends State<SwitchHome> {
  @override
  Widget build(BuildContext context) {
    return 
       HStack([
        RaisedButton(onPressed: ()=>Navigator.of(context).pushNamed(AdminHome.route),
        child: "AdminHome".text.xl2.make(),),
        VxBox().make().w10(context),
        RaisedButton(onPressed: ()=>Navigator.of(context).pushNamed(CustomerHome.route),
        child: "CustomerHome".text.xl2.make(),),
        VxBox().make().w10(context),
        RaisedButton(onPressed: ()=>Navigator.of(context).pushNamed(SellerHome.route),
        child: "SellerHome".text.xl2.make(),),
      ],crossAlignment: CrossAxisAlignment.center,alignment: MainAxisAlignment.center,)
    ;
  }
}