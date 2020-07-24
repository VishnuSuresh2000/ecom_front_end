import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:ecom_front_end/UI/Admin/View/Product/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/ApiCalls/Api.dart';

void addOrUpdateCommonProfile(
    BuildContext context, bool createOrUpdate, String api,
    [CommonProfile commonProfile]) {
  String channel = createOrUpdate ? "Create" : "Update";
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  CommonProfile temp = createOrUpdate ? CommonProfile() : commonProfile;
  temp.sex =createOrUpdate ?  true : null;
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
                        initialValue: createOrUpdate ? null : temp.firstName,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api First Name";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.firstName = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api First Name"),
                      ),
                      TextFormField(
                        initialValue: createOrUpdate ? null : temp.lastName,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api Last Name";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.lastName = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api Last Name"),
                      ),
                      ChangeNotifierProvider(
                        create: (context) => ProductState(value: temp.sex),
                        child: Consumer<ProductState>(
                            builder: (BuildContext context, ls, child) {
                          return CheckboxListTile(
                            value: createOrUpdate ? ls.inKg : temp.sex,
                            onChanged: (value) {
                              ls.inKg = value;
                              temp.sex = ls.inKg;
                            },
                            title: "Sex : ${ls.inKg ? 'male' : 'female'}"
                                .text
                                .make(),
                          );
                        }),
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
                      Center(child: Text("Address Section")),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue:
                            createOrUpdate ? null : temp.address.houseName,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api HouseName & Office Nam";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.address.houseName = value;
                          print("from housename ${temp.address.houseName}");
                        },
                        decoration: InputDecoration(
                            hintText: "Enter $api HouseName & Office Name"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue:
                            createOrUpdate ? null : temp.address.locality,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api Locality";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.address.locality = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api Locality"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue: createOrUpdate ? null : temp.address.city,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api City";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.address.city = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api City"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue:
                            createOrUpdate ? null : temp.address.district,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api district";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.address.district = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api district"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue:
                            createOrUpdate ? null : temp.address.state,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api State";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.address.state = value;
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api State"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue: createOrUpdate
                            ? null
                            : temp.address.pinCode.toString(),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api Pincode";
                          }
                          try {
                            int.parse(value);
                          } catch (e) {
                            return "Must Be Number";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          temp.address.pinCode = int.parse(value);
                        },
                        decoration:
                            InputDecoration(hintText: "Enter $api Pincode"),
                      ),
                      VxBox().make().h4(context),
                      TextFormField(
                        initialValue: createOrUpdate
                            ? null
                            : temp.address.alternateNumber.toString(),
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Plz Enter $api altenative Phone Number";
                          }
                          if (value.length != 10) {
                            return "Phone Number length is Wrong";
                          }

                          return null;
                        },
                        onSaved: (String value) {
                          temp.address.alternateNumber = int.parse(value);
                        },
                        decoration: InputDecoration(
                            hintText: "Enter $api altenative PhoneNumber"),
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
                                  print(temp.toMap());
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
