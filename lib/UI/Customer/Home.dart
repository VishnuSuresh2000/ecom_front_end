import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Channels.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/SwitchView.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Customer/Cart/CartHome.dart';
import 'package:ecom_front_end/UI/Customer/ProductList/view.dart';
import 'package:ecom_front_end/UI/Customer/UrlForCustomers.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomerHome extends StatefulWidget {
  static String route = "CustomerHome";
  //is true then it is on online db
  static bool dev=true;
  static String tempUserId = dev? "5ef361d4ed35de1b9049ef02":"5eef605d8c9c2135341dde77";
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Customer Home".text.make(),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, SwitchHome.route, (route) => false)),
      
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CartHome(
                  customer: CustomerHome.tempUserId,
                ))),
        child: "Cart".text.make(),
      ),
      body: VxBox(
              child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          "Product For sales".text.xl3.make().centered(),
          VxBox().make().h4(context),
          Container(
            child: view(context),
          ).hThreeForth(context)
        ],
      ).wHalf(context).centered())
          .make()
          .p32(),
    );
  }

  Widget view(BuildContext context) {
    return FutureBuilder(
        future: ApiCalls.customGet(ApiNames.getApiNames(apiNames.poductList),
            UrlForCustomers.customerView),
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
              List data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductListView(
                      productlist: Salles.fromMap(data[index]),
                      customedId: CustomerHome.tempUserId,
                    );
                  });
          }
          return null;
        });
  }
}
