import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/ApiCalls/Api.dart';

void addOrUpdateCategory(BuildContext context, bool createOrUpdate,
    [CategorySection categorySection]) {
  String channel = createOrUpdate ? "Create" : "Update";
  String api = "category";

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  CategorySection temp = createOrUpdate ? CategorySection() : categorySection;
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
                            return "Plz enter catogory";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.name = value;
                        },
                        decoration: InputDecoration(hintText: "Enter Catogory"),
                      ),
                      VxBox().make().h4(context),
                      Flex(direction: Axis.horizontal,children: [
                        RaisedButton(
                        onPressed: () async {
                          if(_form.currentState.validate()){
                            _form.currentState.save();
                            var res = createOrUpdate
                              ? await ApiCalls.create("$api", temp.toMap())
                              : await ApiCalls.update(
                                  "$api", temp.id, temp.toMap());
                          showMsgAlertAndRoute(context, res, AdminHome.route);
                          }
                        },
                        child: "$channel".text.make(),
                      ),
                      RaisedButton(onPressed: ()=>Navigator.pop(context),
                      child: "Cancel".text.make(),)
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,)
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ))
            ],
          )).make().hHalf(context).wHalf(context),
        );
      });
}
