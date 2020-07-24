import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Channels.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:ecom_front_end/UI/Admin/View/ProductList/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

void addProductList(BuildContext context) {
  String channel = "Create";
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  Salles temp = Salles();
  Future<List<List>> sec = Future.wait([
    ApiCalls.read('product'),
    ApiCalls.read('seller'),
    ApiCalls.read('farmer')
  ]);

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
            future: sec,
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
                    String productId = " ";
                    List temp2 = snapshot.data[0];
                    List<Product> productList =
                        temp2.map((e) => Product.fromMap(e)).toList();
                    temp2 = snapshot.data[1];
                    List<CommonProfile> sellerList =
                        temp2.map((e) => CommonProfile.fromMap(e)).toList();
                    temp2 = snapshot.data[2];
                    List<CommonProfile> farmerList =
                        temp2.map((e) => CommonProfile.fromMap(e)).toList();
                    temp.toShow = false;
                    return AlertDialog(
                      content: Form(
                        key: _form,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: "Create ProductList".text.make(),
                            ),
                            VxBox().make().h4(context),
                            DropdownButtonFormField<Product>(
                              hint: "Select Product".text.make(),
                              items: productList
                                  .map((Product e) => DropdownMenuItem(
                                        child: Text(
                                          "${e.name}".firstLetterUpperCase(),
                                        ),
                                        key: ValueKey(e.id),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                productId = value.id;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Select the Product";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                productId = value.id;
                              },
                            ),
                            VxBox().make().h4(context),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Plz enter Count Of Product";
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
                                temp.count = int.parse(value);
                              },
                              decoration: InputDecoration(
                                  hintText: "Count of The Product"),
                            ),
                            
                            VxBox().make().h4(context),
                            DropdownButtonFormField<CommonProfile>(
                              hint: "Select Seller".text.make(),
                              items: sellerList
                                  .map((CommonProfile e) => DropdownMenuItem(
                                        child: Text(
                                          "${e.fullName}".firstLetterUpperCase(),
                                        ),
                                        key: ValueKey(e.id),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                temp.seller = value;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Select the Seller";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                temp.seller = value;
                              },
                            ),
                            VxBox().make().h4(context),
                            DropdownButtonFormField<CommonProfile>(
                              hint: "Select Farmer".text.make(),
                              items: farmerList
                                  .map((CommonProfile e) => DropdownMenuItem(
                                        child: Text(
                                          "${e.fullName}".firstLetterUpperCase(),
                                        ),
                                        key: ValueKey(e.id),
                                        value: e,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                temp.farmer = value;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Select the Farmer";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                temp.farmer = value;
                              },
                            ),
                            VxBox().make().h4(context),
                            ChangeNotifierProvider(
                              create: (context) => ProductListState(),
                              child: Consumer<ProductListState>(
                                  builder: (BuildContext context, ls, child) {
                                return CheckboxListTile(
                                  value: ls.toShow,
                                  onChanged: (value) {
                                    ls.toShow = value;
                                    temp.toShow = ls.toShow;
                                  
                                  },
                                  title: "Show the Product".text.make(),
                                );
                              }),
                            ),
                            Flex(
                              direction: Axis.horizontal,
                              children: [
                                RaisedButton(
                                  onPressed: () async {
                                    if (_form.currentState.validate()) {
                                      _form.currentState.save();
                                      print(temp.toMapToAdd());
                                      try {
                                        var res = await ApiCalls.create(
                                            "${ApiNames.getApiNames(apiNames.poductList)}/$productId",
                                            temp.toMapToAdd());
                                        showMsgAlertAndNamedRoute(context, res,
                                            AdminHome.route, false);
                                      } catch (e) {
                                        showMsgAlertAndNamedRoute(context, "$e",
                                            AdminHome.route, true);
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
                        ),
                      ).hHalf(context).wHalf(context),
                    );
                  }
              }
              return Container();
            });
      });
}
