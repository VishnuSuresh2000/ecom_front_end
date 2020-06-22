import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Channels.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Customer/Home.dart';
import 'package:ecom_front_end/UI/Customer/UrlForCustomers.dart';
import 'package:flutter/cupertino.dart';

class CustomerFunctions {
  static addProductToCart(
      Map<String, dynamic> data, BuildContext context) async {
    var temp;
    bool isError;

    try {
      temp = await ApiCalls.customPost(ApiNames.getApiNames(apiNames.cart),
          UrlForCustomers.customerCart,data);
      isError = false;
    } catch (e) {
      temp = e.toString();
      isError = true;
    } finally {
      print(temp);
      showMsgAlertAndNamedRoute(context,temp, CustomerHome.route, isError);
    }
  }
}
