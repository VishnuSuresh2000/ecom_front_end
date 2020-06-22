import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartView extends StatelessWidget {
  final Cart cart;
  const CartView({Key key, this.cart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return ExpansionTile(
      title: "Product : ${cart.productList.product.name.firstLetterUpperCase()}".text.make(),
      children: [
        ListTile(
          title:
              "Product : ${cart.productList.product.name.firstLetterUpperCase()}"
                  .text
                  .make(),
        ),
        ListTile(
          title:
              "Count : ${cart.count.toString().firstLetterUpperCase()}"
                  .text
                  .make(),
        ),
        ListTile(
          title:
              "Payment : ${cart.paymentComplete}"
                  .text
                  .make(),
        ),
        ListTile(
          title: "Total amount : ${cart.count*cart.productList.amount}".text.make(),
        )
        
      ],
    ).card.make();
  }
}
