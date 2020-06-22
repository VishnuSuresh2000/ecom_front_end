import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Customer/Functions.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductListView extends StatelessWidget {
  final ProductList productlist;
  final String customedId;

  const ProductListView({Key key, this.productlist, this.customedId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: "Name : ${productlist.product.name.firstLetterUpperCase()}"
          .text
          .xl
          .make(),
      children: [
        ListTile(
          title:
              "Category\t:\t${productlist.product.category.name.firstLetterUpperCase()}"
                  .text
                  .make(),
        ),
        ListTile(
          title: "Amount\t:\t${productlist.amount}".text.make(),
        ),
        ListTile(
          title: "Seller\t:\t${productlist.seller.name.firstLetterUpperCase()}"
              .text
              .make(),
        ),
        ListTile(
          title: "Farmer \t:\t${productlist.farmer.name.firstLetterUpperCase()}"
              .text
              .make(),
        ),
        ListTile(
          title: "Count\t:\t${productlist.count}".text.make(),
        ),
        ListTile(
          title:
              "Date Of Creation\t:\t${productlist.dateOfCreation}".text.make(),
        ),
        ListTile(
          title: "Date Of Upadtion\t:\t${productlist.dateOfUpdate}".text.make(),
        ),
        ListTile(
          title: "Is Verified\t:\t${productlist.isVerified}".text.make(),
        ),
        ListTile(
          title: "To Show\t:\t${productlist.toShow}".text.make(),
        ),
        VxBox().make().h4(context),
        RaisedButton(
          onPressed: () => addToCart(customedId, productlist.id, context),
          child: "Buy".text.make(),
        ).centered()
      ],
    ).card.make();
  }

  void addToCart(String customerId, String productid, BuildContext context) {
    TextEditingController temp = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: TextField(
              controller: temp,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Count",
              ),
            ),
            actions: [
              RaisedButton(
                onPressed: () async {
                  print(temp.text);
                  await CustomerFunctions.addProductToCart({
                    "productlist_id": productid,
                    "customer_id": customedId,
                    "count": int.parse(temp.text.toString())
                  }, context);
                },
                child: Text("Add To cart"),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Cancel"),
              )
            ],
          );
        });
  }
}
