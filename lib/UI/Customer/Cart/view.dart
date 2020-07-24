// import 'package:ecom_front_end/ApiCalls/Api.dart';
// import 'package:ecom_front_end/Sections/Channels.dart';
// import 'package:ecom_front_end/Sections/Modules.dart';
// import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
// import 'package:ecom_front_end/UI/Customer/Cart/CartHome.dart';
// import 'package:ecom_front_end/UI/Customer/Home.dart';
// import 'package:ecom_front_end/UI/Customer/UrlForCustomers.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CartView extends StatelessWidget {
//   final Cart cart;
//   const CartView({Key key, this.cart}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     //${cart.productList.product.name.firstLetterUpperCase()}
//     return ExpansionTile(
//       title: "Product : "
//           .text
//           .make(),
//       children: [
//         // ListTile(
//         //   title:
//         //       "Product : ${cart.productList.product.name.firstLetterUpperCase()}"
//         //           .text
//         //           .make(),
//         // ),
//         ListTile(
//           title: "Count : ${cart.count.toString().firstLetterUpperCase()}"
//               .text
//               .make(),
//         ),
//         ListTile(
//           title: "Payment : ${cart.paymentComplete}".text.make(),
//           trailing: RaisedButton(
//             onPressed: () async => cashOnDelivary(context),
//             child: "${!cart.paymentComplete ? 'COD' : 'Cancell Order'}"
//                 .text
//                 .xl
//                 .color(cart.paymentComplete ? Vx.red800 : Vx.blue800)
//                 .make(),
//             color: cart.paymentComplete ? Vx.red300 : Vx.blue300,
//           ),
//         ),
//         // ListTile(
//         //   title: "Total amount : ${cart.count * cart.productList.amount}"
//         //       .text
//         //       .make(),
//         // )
//       ],
//     ).card.make();
//   }

//   void cashOnDelivary(BuildContext context) async {
//     var temp;
//     var isError;
//     try {
//       temp = await ApiCalls.customGet(ApiNames.getApiNames(apiNames.cart),
//           "${!cart.paymentComplete?UrlForCustomers.payOrder:UrlForCustomers.cancelOrder}/${cart.id}");
//       isError = false;
//     } catch (e) {
//       temp = e.toString();
//       isError = true;
//     } finally {
//       showMsgAlertAndRoute(
//           context,
//           temp,
//           () async => await Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => CartHome(
//                     customer: CustomerHome.tempUserId,
//                   ))),
//           isError,
//           "cart");
//     }
//   }
// }
