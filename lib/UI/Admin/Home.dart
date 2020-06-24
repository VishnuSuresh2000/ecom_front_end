import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/UI/Admin/View/CommonProfile/view.dart';
import 'package:ecom_front_end/UI/Admin/View/Product/view.dart';
import 'package:ecom_front_end/UI/Admin/View/ProductList/Add.dart';
import 'package:ecom_front_end/UI/Admin/View/ProductList/view.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'CustomSection.dart';
import 'package:ecom_front_end/Sections/Channels.dart';
import 'package:ecom_front_end/UI/Admin/View/Category/view.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/View/Category/AddOrUpdatePage.dart';
import 'package:ecom_front_end/UI/Admin/View/Product/AddOrUpdate.dart';
import 'package:ecom_front_end/UI/Admin/View/CommonProfile/AddOrUpdate.dart';

class AdminHome extends StatefulWidget {
  static String route = '/adminHome';
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  apiNames api = apiNames.category;
  List buttons = <String>[...ApiNames.api.values];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Admin Home".text.make(),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => switchCreatePhase(context)),
      body: VxBox(
          child: ListView(
        children: [
          HStack(
            [
              ...buttons.map((e) => topLayerButton(
                      e.toString().firstLetterUpperCase(),
                      e == ApiNames.getApiNames(api), (String value) {
                    api = ApiNames.getApi(value);
                    setState(() {});
                  }))
            ],
            alignment: MainAxisAlignment.spaceAround,
          ),
          VxBox().make().h4(context),
          VStack(
            [viewSections().wHalf(context).hThreeForth(context)],
            crossAlignment: CrossAxisAlignment.center,
          )
        ],
      )).make().p32(),
    );
  }

  Widget viewSections() {
    return FutureBuilder(
        future: ApiCalls.read(ApiNames.getApiNames(api)),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return errorBlock("An Error On the Network Connection");
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator()
                  .box
                  .alignCenter
                  .make()
                  .wh10(context);
            case ConnectionState.done:
              if (snapshot.hasError) {
                return errorBlock(
                    "${snapshot.error.toString()}from futher builder");
              }
              return switchSections(snapshot.data);
          }
          return null;
        });
  }

  void switchCreatePhase(BuildContext context) {
    switch (api) {
      case apiNames.category:
        addOrUpdateCategory(context, true);
        break;
      case apiNames.product:
        addOrUpdateProduct(context, true);
        break;
      case apiNames.farmer:
      case apiNames.seller:
        addOrUpdateCommonProfile(
            context, true, ApiNames.getApiNames(api).firstLetterUpperCase());
        break;
      case apiNames.poductList:
        addProductList(context);
        break;
      default:
        break;
    }
  }

  Widget switchSections(List data) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        switch (api) {
          case apiNames.category:
            return CategoryView(
              key: ValueKey(index),
              category: CategorySection.fromMap(data[index]),
              callback: (String msg, String id) => updateDeleteBlock(
                  msg,
                  id,
                  () => addOrUpdateCategory(
                      context, false, CategorySection.fromMap(data[index])),
                  (id) => deleteRecord(
                      context, ApiNames.getApiNames(api), id, AdminHome.route)),
            );
          case apiNames.product:
            return ProductView(
              key: ValueKey(index),
              product: Product.fromMap(data[index]),
              callback: (String msg, String id) => updateDeleteBlock(
                  msg,
                  id,
                  () => addOrUpdateProduct(
                      context, false, Product.fromMap(data[index])),
                  (id) => deleteRecord(
                      context, ApiNames.getApiNames(api), id, AdminHome.route)),
            );
          case apiNames.seller:
          case apiNames.farmer:
            return CommonProfileView(
              commonProfile: CommonProfile.fromMap(data[index]),
              callback: (String msg, String id) => updateDeleteBlock(
                  msg,
                  id,
                  () => addOrUpdateCommonProfile(
                      context,
                      false,
                      ApiNames.getApiNames(api),
                      CommonProfile.fromMap(data[index])),
                  (id) => deleteRecord(
                      context, ApiNames.getApiNames(api), id, AdminHome.route)),
                      api: api,
            );
          case apiNames.poductList:
            return ProductListView(
              productlist: ProductList.fromMap(data[index]),
            );
          default:
            break;
        }
        return Container();
      },
      itemCount: data.length,
    ).wHalf(context);
  }
}
