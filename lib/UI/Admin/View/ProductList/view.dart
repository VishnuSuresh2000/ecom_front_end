import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Channels.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductListView extends StatelessWidget {
  final ProductList productlist;

  const ProductListView({Key key, this.productlist}) : super(key: key);

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
          title: "Amount\t:\t${productlist.amount}"
              .text
              .make(),
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
          trailing: verifiedButton(
              context,
              ApiNames.getApiNames(apiNames.poductList),
              productlist.id,
              productlist.isVerified),
        ),
        ListTile(
          title: "To Show\t:\t${productlist.toShow}".text.make(),
          trailing: RaisedButton(
            onPressed: () async =>
                toShowSet(context, productlist.id, !productlist.toShow),
            child: "${!productlist.toShow ? 'Show' : 'Not Show'}"
                .text
                .xl
                .color(!productlist.toShow ? Vx.blue800 : Vx.red800)
                .make(),
          ),
        ),
        deleteBlock(
            productlist.id,
            (id) => deleteRecord(
                context,
                ApiNames.getApiNames(apiNames.poductList),
                id,
                AdminHome.route)).centered()
      ],
    ).card.make();
  }

  void toShowSet(BuildContext context, String id, bool value) async {
    var temp;
    bool isError;
    try {
      temp =
          await ApiCalls.customPut("productlist", "toShow/$value", {"id": id});
      isError = false;
    } catch (e) {
      temp = e;
      isError = true;
    } finally {
      showMsgAlertAndNamedRoute(context, temp, AdminHome.route, isError);
    }
  }
}
