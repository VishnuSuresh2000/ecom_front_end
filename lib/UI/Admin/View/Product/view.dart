import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

// ignore: must_be_immutable
class ProductView extends StatelessWidget {
  final Product product;
  final Function callback;
  List<int> selectedFile;
  Uint8List bytesData;
  String filename;
  ProductView({Key key, this.product, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: "Name : ${product.name.firstLetterUpperCase()}".text.xl.make(),
      children: [
        ListTile(
          title: "Description\t:\t${product.description}".text.make(),
        ),
        ListTile(
          title: "Has Img\t:\t${product.hasImg}".text.make(),
          subtitle: Text("Only Png Files Upload"),
          trailing: 
              RaisedButton(
                  onPressed: () => startWebFilePicker(product, context),
                  child: Text("UploadImag"),
                )
              ,
        ),
        if(product.hasImg??false) Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            child: Image.network("${ApiCalls.host}/product/getImage/${product.name}"),
          ),
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

  startWebFilePicker(Product name, BuildContext context) async {
    try {
      html.InputElement uploadInput = html.FileUploadInputElement();
      uploadInput.multiple = true;
      uploadInput.draggable = true;
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;

        final file = files[0];
        filename = file.name;
        final reader = new html.FileReader();

        reader.onLoadEnd.listen((e) {
          _handleResult(reader.result, name, context);
        });
        reader.readAsDataUrl(file);
      });
    } catch (e) {
      print(e);
      showMsgAlertAndNamedRoute(context, "from start web $e", AdminHome.route, true);
    }
  }

  void _handleResult(
      Object result, Product product, BuildContext context) async {
    try {
      bytesData = Base64Decoder().convert(result.toString().split(",").last);
      selectedFile = bytesData;
      FormData data = FormData.fromMap({
        'imgUrl': MultipartFile.fromBytes(bytesData,
            filename: "${product.name}.png")
      });
      var response = await ApiCalls.productImageUpload(data, product.id);
      print(response);
      showMsgAlertAndNamedRoute(context, response, AdminHome.route, false);
    } catch (e) {
      print(e);
      showMsgAlertAndNamedRoute(context, "from _handle $e", AdminHome.route, true);
    }
  }
}
