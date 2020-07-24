import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:ecom_front_end/UI/Admin/View/Product/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

void addOrUpdateProduct(BuildContext context, bool createOrUpdate,
    [Product product]) {
  String channel = createOrUpdate ? "Create" : "Update";
  String api = "product";

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  Product temp = createOrUpdate ? Product() : product;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: ApiCalls.read("category"),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return VxBox(
                          child: "Error on the Intetwork"
                              .text
                              .red600
                              .xl2
                              .make()
                              .centered())
                      .make();
                  break;
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return CircularProgressIndicator().wh(30, 30).centered();
                  break;
                case ConnectionState.done:
                  {
                    if (snapshot.hasError) {
                      return errorBlock(snapshot.error);
                    }
                    List temp2 = snapshot.data;
                    List<CategorySection> cat =
                        temp2.map((e) => CategorySection.fromMap(e)).toList();
                    temp.inKg = createOrUpdate ? true : null;
                    return AlertDialog(
                      content: VxBox(
                          child: ListView(
                        children: [
                          Form(
                              key: _form,
                              child: VStack(
                                [
                                  VxBox().make().h4(context),
                                  "$channel ${api.firstLetterUpperCase()}"
                                      .text
                                      .xl2
                                      .make(),
                                  VxBox().make().h4(context),
                                  TextFormField(
                                    initialValue:
                                        createOrUpdate ? null : temp.name,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Plz enter Product Name";
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      temp.name = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Product Name"),
                                  ),
                                  TextFormField(
                                    initialValue: createOrUpdate
                                        ? null
                                        : temp.description,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Plz enter description";
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      temp.description = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter description"),
                                  ),
                                  DropdownButtonFormField<CategorySection>(
                                    hint: "Select Category".text.make(),
                                    value: createOrUpdate
                                        ? null
                                        : cat.singleWhere((element) =>
                                            element.name ==
                                                temp.category.name &&
                                            element.id == temp.category.id),
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return "need the field";
                                      }
                                      return null;
                                    },
                                    items: cat
                                        .map((CategorySection e) =>
                                            DropdownMenuItem<CategorySection>(
                                                key: ValueKey(e.id),
                                                value: e,
                                                child: Text("${e.name}"
                                                    .firstLetterUpperCase())))
                                        .toList(),
                                    onChanged: (value) {
                                      temp.category = value;
                                    },
                                    onSaved: (value) {
                                      temp.category = value;
                                    },
                                  ),
                                  VxBox().make().h4(context),
                                  TextFormField(
                                     initialValue: createOrUpdate
                                        ? null
                                        : temp.amount.toString(),
                                    keyboardType: TextInputType.number,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return "Plz enter Amount Of Product";
                                      }
                                      if (value.isNotEmpty) {
                                        try {
                                          int.parse(value);
                                        } catch (e) {
                                          return "Must be A Number";
                                        }
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      temp.amount = int.parse(value);
                                    },
                                    onChanged: (String value){
                                      temp.amount = int.parse(value);
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Amount of the Product"),
                                  ),
                                  ChangeNotifierProvider(
                                    create: (context) => ProductState(),
                                    child: Consumer<ProductState>(builder:
                                        (BuildContext context, ls, child) {
                                      return CheckboxListTile(
                                        value: createOrUpdate
                                            ? ls.inKg
                                            : temp.inKg,
                                        onChanged: (value) {
                                          ls.inKg = value;
                                          temp.inKg = ls.inKg;
                                        },
                                        title: "In Kg".text.make(),
                                      );
                                    }),
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
                                                      "$api",
                                                      temp.id,
                                                      temp.toMap());

                                              showMsgAlertAndNamedRoute(context,
                                                  res, AdminHome.route, false);
                                            } catch (e) {
                                              showMsgAlertAndNamedRoute(context,
                                                  "$e", AdminHome.route, true);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                  )
                                ],
                                crossAlignment: CrossAxisAlignment.center,
                              ))
                        ],
                      )).make().hHalf(context).wHalf(context),
                    );
                  }
              }
              return Container();
            });
      });
}
