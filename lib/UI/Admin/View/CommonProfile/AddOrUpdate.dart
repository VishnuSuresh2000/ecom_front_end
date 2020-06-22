import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/ApiCalls/Api.dart';

void addOrUpdateCommonProfile(
    BuildContext context, bool createOrUpdate, String api,
    [CommonProfile commonProfile]) {
  String channel = createOrUpdate ? "Create" : "Update";
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  CommonProfile temp = createOrUpdate ? CommonProfile() : commonProfile;
  // String tempNo = createOrUpdate ? null : temp.phoneNumber.toString();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: VxBox(
              child: ListView(
            children: [
              Form(
                  key: _form,
                  child: VStack(
                    [
                      VxBox().make().h4(context),
                      "$channel ${api.firstLetterUpperCase()}".text.xl2.make(),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue: createOrUpdate ? null : temp.name,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api Name";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.name = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api Name"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue: createOrUpdate ? null : temp.address,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api Address";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.address = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api Address"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue:
                            createOrUpdate ? null : temp.phoneNumber.toString(),
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api Name";
                          }
                          if (value.length != 10) {
                            return "Phone Number length is Wrong";
                          }

                          return null;
                        },
                        onSaved: (String value) {
                          temp.phoneNumber = int.parse(value);
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api PhoneNumber"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue: createOrUpdate ? null : temp.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isNotEmpty &&
                              !value.contains(new RegExp(
                                  r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$'))) {
                            return "Plz Enter $api Email on the formate\nEg: example@email.com";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.email = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api Email"),
                      ),
                      VxBox().make().h4(context),
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          RaisedButton(
                            onPressed: () async {
                              if (_form.currentState.validate()) {
                                _form.currentState.save();
                                try {
                                  var res = createOrUpdate
                                      ? await ApiCalls.create(
                                          "$api", temp.toMap())
                                      : await ApiCalls.update(
                                          "$api", temp.id, temp.toMap());
                                  showMsgAlertAndNamedRoute(
                                      context, res, AdminHome.route, false);
                                } catch (e) {
                                  showMsgAlertAndNamedRoute(
                                      context, "$e", AdminHome.route, true);
                                }
                              }
                            },
                            child: "$channel".text.make(),
                          ),
                          RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: "Cancel".text.make(),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      )
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ))
            ],
          )).make().hHalf(context).wHalf(context),
        );
      });
}
