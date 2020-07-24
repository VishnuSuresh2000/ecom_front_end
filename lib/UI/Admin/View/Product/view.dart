import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductView extends StatelessWidget {
  final Product product;
  final Function callback;

  const ProductView({Key key, this.product, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: "Name : ${product.name.firstLetterUpperCase()}".text.xl.make(),
      children: [
        ListTile(
          title: "Description\t:\t${product.description}".text.make(),
        ),
        ListTile(
          title: "Category\t:\t${product.category.name.firstLetterUpperCase()}"
              .text
              .make(),
        ),
        ListTile(
          title: "In Kg\t:\t${product.inKg}".text.make(),
        ),
        ListTile(
          title: "Amount\t:\t${product.amount} ".text.xl.make(),
        ),
        callback("Product", product.id)
      ],
    ).card.make();
  }
}
