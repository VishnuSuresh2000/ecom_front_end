import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:velocity_x/velocity_x.dart';

Widget topLayerButton(String name, bool status, Function callback) {
  return OutlineButton(
    onPressed: () => callback(name),
    child: "$name".text.color(status ? Vx.green800 : Vx.green300).xl2.make(),
    borderSide: BorderSide(width: 8, color: status ? Vx.green800 : Vx.green300),
    shape:
        RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
  );
}

Widget errorBlock(String msg) {
  return "$msg".text.red500.xl4.make().centered();
}

void deleteRecord(BuildContext context,String section,String id,String route)async{
  var res=await ApiCalls.delete(section, id);
  showMsgAlertAndRoute(context, res, route);
}

Widget updateDeleteBlock(
    String msg, String id, Function update, Function delete,
    [dynamic data]) {
  return Flex(
    direction: Axis.horizontal,
    children: [
      RaisedButton(
        onPressed: () => update(),
        child: "Update".text.blue700.make(),
        color: Vx.blue300,
      ),
      RaisedButton(
        onPressed: () => delete(id),
        child: "Delete".text.red700.make(),
        color: Vx.red300,
      )
    ],
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  );
}

void showMsgAlertAndRoute(
    BuildContext context, Map<String, dynamic> response, String route) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              "${response['msg']}",
              style: TextStyle(
                  fontSize: 20,
                  color: response['error'] ? Vx.red800 : Vx.blue800),
            ),
            actions: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(route, (route) => false);
                },
                child: Text("${route.replaceFirst(RegExp(r'0'), " ")}"),
              ).centered()
            ],
          ));
}
