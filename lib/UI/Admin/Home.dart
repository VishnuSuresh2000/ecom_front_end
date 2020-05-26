import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'CustomSection.dart';
import 'package:ecom_front_end/Sections/Channels.dart';
import 'package:ecom_front_end/UI/Admin/View/Category/view.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/View/Category/AddOrUpdatePage.dart';

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
      floatingActionButton: FloatingActionButton(
          onPressed: () => addOrUpdateCategory(context, true)),
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
            [viewSections().wHalf(context).hFull(context)],
            crossAlignment: CrossAxisAlignment.center,
          )
        ],
      )).make().p64(),
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
              return switchSections(snapshot.data);
          }
          return null;
        });
  }

  Widget switchSections(Map<String, dynamic> data) {
    if (!data['error']) {
      List temp = data['data'];
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          switch (api) {
            case apiNames.category:
              return CategoryView(
                category: CategorySection.fromMap(temp[index]),
                callback: (String msg, String id) => updateDeleteBlock(
                  msg,
                  id,
                  ()=>addOrUpdateCategory(
                      context, false, CategorySection.fromMap(temp[index])),
                  (id)=>deleteRecord(context, ApiNames.getApiNames(api), id,AdminHome.route)
                ),
              ).wHalf(context);
            case apiNames.product:
              // TODO: Handle this case.
              break;
            case apiNames.farmer:
              // TODO: Handle this case.
              break;
            case apiNames.seller:
              // TODO: Handle this case.
              break;
          }
          return Container();
        },
        itemCount: temp.length,
      );
    }
    return errorBlock("${data['msg']}");
  }
}
