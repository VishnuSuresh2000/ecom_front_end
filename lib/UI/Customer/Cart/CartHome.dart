// import 'package:ecom_front_end/ApiCalls/Api.dart';
// import 'package:ecom_front_end/Sections/Channels.dart';
// import 'package:ecom_front_end/Sections/Modules.dart';
// import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
// import 'package:ecom_front_end/UI/Customer/Cart/view.dart';
// import 'package:ecom_front_end/UI/Customer/Home.dart';
// import 'package:ecom_front_end/UI/Customer/UrlForCustomers.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CartHome extends StatefulWidget {
//   static String route = "customerCart";
//   final String customer;
//   const CartHome({Key key, this.customer}) : super(key: key);
//   @override
//   _CartHomeState createState() => _CartHomeState();
// }

// class _CartHomeState extends State<CartHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: "Cart".text.make(),
//         centerTitle: true,
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pushNamedAndRemoveUntil(
//                 context, CustomerHome.route, (route) => false)),
//       ),
//       body: VxBox(
//           child: FutureBuilder(
//               future: showCart(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.none:
//                     return errorBlock("An Error On the Network Connection");
//                   case ConnectionState.active:
//                   case ConnectionState.waiting:
//                     return CircularProgressIndicator()
//                         .box
//                         .alignCenter
//                         .make()
//                         .wh10(context);
//                   case ConnectionState.done:
//                     if (snapshot.hasError) {
//                       return errorBlock(
//                           "${snapshot.error.toString()}from futher builder");
//                     }
//                     List data = snapshot.data;
//                     return ListView.builder(
//                         itemCount: data.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           Cart temp = Cart.fromMap(data[index]);
//                           return CartView(
//                             cart: temp,
//                           );
//                         });
//                 }
//                 return null;
//               })).make().p64(),
//     );
//   }

//   Future showCart() async {
//     return await ApiCalls.customGet(ApiNames.getApiNames(apiNames.cart),
//         "${UrlForCustomers.customerCart}/${widget.customer}");
//   }
// }
