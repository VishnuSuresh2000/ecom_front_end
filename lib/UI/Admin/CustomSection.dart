import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget topLayerButton(String name, bool status, Function callback) {
  return OutlineButton(
    onPressed: () => callback(name),
    child: "$name".text.color(status ? Vx.green800 : Vx.green300).xl2.make(),
  );
}

Widget errorBlock(String msg) {
  return "$msg".text.red500.xl4.make().centered();
}


Widget updateDeleteBlock(String msg,String id){
  return HStack([
    RaisedButton(onPressed: (){},child: "Update".text.blue700.make(),),
    RaisedButton(onPressed: (){},child: "Delete".text.red700.make(),)
  ]);
}