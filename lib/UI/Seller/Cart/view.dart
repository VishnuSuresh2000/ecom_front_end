import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SellerCartView extends StatelessWidget {
  final Cart cart;
  const SellerCartView({Key key, this.cart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      //${cart.productList.product.name.firstLetterUpperCase()}
      title: "Product : "
          .text
          .make(),
      children: [
        // ListTile(
        //   title:
        //       "Product : ${cart.productList.product.name.firstLetterUpperCase()}"
        //           .text
        //           .make(),
        // ),
        ListTile(
          title: "Count : ${cart.count.toString().firstLetterUpperCase()}"
              .text
              .make(),
        ),
        ListTile(
          title: "Total amount : ${cart.count * cart.productList.amount}"
              .text
              .make(),
        ),
        customerDetails(),
        ListTile(
          title: "Delivered : ${cart.completed}".text.make(),
          trailing:!cart.completed? RaisedButton(onPressed: (){},
          child: "Done".text.make(),):null,
        )
      ],
    ).card.make();
  }

  Widget customerDetails() {
    return FutureBuilder(
        future: ApiCalls.customGet("customer", "${cart.customerId}"),
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
              CommonProfile commonProfile =
                  CommonProfile.fromMap(snapshot.data);
              return ExpansionTile(
                title: "Customer : ${commonProfile.name.firstLetterUpperCase()}"
                    .text
                    .xl
                    .make(),
                children: [
                  ListTile(
                    title: "Address\t:\t${commonProfile.address}".text.make(),
                  ),
                  ListTile(
                    title: "Phone Number\t:\t${commonProfile.phoneNumber}"
                        .text
                        .make(),
                  ),
                  ListTile(
                    title: "Email\t:\t${commonProfile.email}".text.make(),
                  ),
                ],
              );
          }
          return null;
        });
  }
}
