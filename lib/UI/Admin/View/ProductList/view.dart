import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductListView extends StatelessWidget {
  final Map<String, dynamic> productlist;

  const ProductListView({Key key, this.productlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ${productlist.product.name.firstLetterUpperCase()}
    // return buildExpansionTile(context).card.make();
    Product product = Product.fromMap(productlist);
    List res = productlist['salles'];
    List<Salles> temp = res.map((e) {
      return Salles.fromMap(e);
    }).toList();

    return buildExpansionTile(context, product, temp).card.make();
  }

  ExpansionTile buildExpansionTile(
      BuildContext context, Product product, List<Salles> temp) {
    return ExpansionTile(
      title: "Name\t:\t${product.name.firstLetterUpperCase()} ".text.xl.make(),
      children: temp
          .map((e) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
                  title: "Seller\t:\t${e.seller.fullName.firstLetterUpperCase()} "
                      .text
                      .xl
                      .make(),
                  children: [
                    ListTile(
                      title: "Farmer\t:\t${e.farmer.fullName.firstLetterUpperCase()} "
                          .text
                          .xl
                          .make(),
                    ),
                   
                    
                    ListTile(
                      title: "Count\t:\t${e.count} ".text.xl.make(),
                    ),
                    ListTile(
                      title: "Date Of Creation\t:\t${e.dateOfCreation} ".text.xl.make(),
                    ),
                    ListTile(
                      title: "Date Of Creation\t:\t${e.dateOfUpdate} ".text.xl.make(),
                    ),
                    ListTile(
                      title: "isVerified\t:\t${e.isVerified} ".text.xl.make(),
                      trailing: verifiedButtonCusttom(context, "toVerifiy", e.id,e.isVerified),
                    ),
                    ListTile(
                      title: "To Show\t:\t${e.toShow} ".text.xl.make(),
                       trailing: verifiedButtonCusttom(context, "toShow", e.id,e.toShow),
                    ),
                  ],
                ),
          ))
          .toList(),
    );
  }

  void toSet(BuildContext context,String section ,String id, bool value) async {
    var temp;
    bool isError;
    try {
      temp =
          await ApiCalls.customPut("salles", "$section", {"id": id,"value":value});
      isError = false;
    } catch (e) {
      temp = e;
      isError = true;
    } finally {
      showMsgAlertAndNamedRoute(context, temp, AdminHome.route, isError);
    }
  }
  Widget verifiedButtonCusttom(BuildContext context, String section, String id, bool value) {
  return RaisedButton(
    onPressed: () async => toSet(context, section, id, !value),
    child: "${!value ? 'Verify' : 'Un Verify'}"
        .text
        .xl
        .color(!value ? Vx.blue800 : Vx.red800)
        .make(),
  );
}
}
// deleteBlock(
//             productlist.id,
//             (id) => deleteRecord(
//                 context,
//                 ApiNames.getApiNames(apiNames.poductList),
//                 id,
//                 AdminHome.route)).centered()
