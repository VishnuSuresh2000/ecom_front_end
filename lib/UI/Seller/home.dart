// import 'package:ecom_front_end/ApiCalls/Api.dart';
// import 'package:ecom_front_end/Sections/Channels.dart';
// import 'package:ecom_front_end/Sections/Modules.dart';
// import 'package:ecom_front_end/SwitchView.dart';
// import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
// import 'package:ecom_front_end/UI/Seller/Cart/view.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class SellerHome extends StatefulWidget {
//   //is true then it is on online db
//   static bool dev = true;
//   static String sellerId =
//       dev ? "5ef0b7897546f921142fab2a" : "5eecb7d37ea9451a48d3dae9";
//   static String route = "sellerHome";
//   @override
//   _SellerHomeState createState() => _SellerHomeState();
// }

// class _SellerHomeState extends State<SellerHome> {
//   @override
//   Widget build(BuildContext context) {
//     List buttons = <String>[
//       ApiNames.getApiNames(apiNames.poductList),
//       ApiNames.getApiNames(apiNames.cart)
//     ];
//     apiNames api = apiNames.poductList;
//     var scaffold = Scaffold(
//       appBar: AppBar(
//         title: "Seller Delivary Secttion".text.make(),
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pushNamedAndRemoveUntil(
//                 context, SwitchHome.route, (route) => false)),
//       ),
//       body: VxBox(
//           child: ListView(
//         children: [
//           HStack(
//             [
//               ...buttons.map((e) => topLayerButton(
//                       e.toString().firstLetterUpperCase(),
//                       e == ApiNames.getApiNames(api), (String value) {
//                     api = ApiNames.getApi(value);
//                     setState(() {});
//                   }))
//             ],
//             alignment: MainAxisAlignment.spaceAround,
//           ),
//         ],
//       )).make(),
//     );
//     return Container();
//   }

//   Widget futherSection() {
//     return FutureBuilder(
//         future: ApiCalls.customGet(ApiNames.getApiNames(apiNames.cart),
//             "sellerCart/${SellerHome.sellerId}"),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               return errorBlock("An Error On the Network Connection");
//             case ConnectionState.active:
//             case ConnectionState.waiting:
//               return CircularProgressIndicator()
//                   .box
//                   .alignCenter
//                   .make()
//                   .wh10(context);
//             case ConnectionState.done:
//               if (snapshot.hasError) {
//                 return errorBlock(
//                     "${snapshot.error.toString()}from futher builder");
//               }

//               // return Container(child: snapshot.data.toString().text.make(),);

//               List data = snapshot.data;
//               return ListView.builder(
//                   itemCount: data.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container();
//                   });
//           }
//           return null;
//         }).wThreeForth(context).centered().py16();
//   }
// }
