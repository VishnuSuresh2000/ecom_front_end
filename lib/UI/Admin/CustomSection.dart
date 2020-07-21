import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:flutter/material.dart';
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

void deleteRecord(
    BuildContext context, String section, String id, String route) async {
  try {
    var res = await ApiCalls.delete(section, id);
    showMsgAlertAndNamedRoute(context, res, route, false);
  } catch (e) {
    showMsgAlertAndNamedRoute(context, "$e", route, false);
  }
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
      deleteBlock(id, delete)
    ],
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  );
}

Widget deleteBlock(String id, Function delete) {
  return RaisedButton(
    onPressed: () => delete(id),
    child: "Delete".text.red700.make(),
    color: Vx.red300,
  );
}

void showMsgAlertAndRoute(BuildContext context, String response, Function route,
    bool error, String name) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(
              "$response",
              style: TextStyle(
                  fontSize: 20, color: error ? Vx.red800 : Vx.blue800),
            ),
            actions: [
              RaisedButton(
                onPressed: () => route(),
                child: Text("$name"),
              ).centered()
            ],
          ));
}

void showMsgAlertAndNamedRoute(
    BuildContext context, String response, String route, bool error) {
  showMsgAlertAndRoute(context, response, () {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }, error, route.replaceFirst(RegExp(r'0'), " "));
}

Widget verifiedButton(
    BuildContext context, String section, String id, bool value) {
  return RaisedButton(
    onPressed: () async => toVerify(context, section, id, !value),
    child: "${!value ? 'Verify' : 'Un Verify'}"
        .text
        .xl
        .color(!value ? Vx.blue800 : Vx.red800)
        .make(),
  );
}

void toVerify(
    BuildContext context, String section, String id, bool value) async {
  var temp;
  bool isError;
  try {
    temp = await ApiCalls.customPut("$section", "verify/$value", {"id": id});
    isError = false;
  } catch (e) {
    temp = e;
    isError = true;
  } finally {
    showMsgAlertAndNamedRoute(context, temp, AdminHome.route, isError);
  }
}

