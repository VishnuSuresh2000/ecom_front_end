import 'dart:convert';
import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:ecom_front_end/ApiCalls/Api.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:ecom_front_end/UI/Admin/Home.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ecom_front_end/Sections/Modules.dart';

// ignore: must_be_immutable
class CategoryView extends StatelessWidget {
  final CategorySection category;
  final Function callback;
  List<int> selectedFile;
  Uint8List bytesData;
  String filename;
   CategoryView({Key key, this.category, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: "Name : ${category.name.firstLetterUpperCase()}".text.xl.make(),
      children: [
        ListTile(
          title: "Has Img\t:\t${category.hasImg}".text.make(),
          subtitle: Text("Only Png Files Upload"),
          trailing: RaisedButton(
            onPressed: () => startWebFilePicker(category, context),
            child: Text("UploadImag"),
          ),
        ),
        if (category.hasImg )
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              child: Image.network(
                  "${ApiCalls.host}/category/getImage/${category.name}"),
            ),
          ),
        callback("category", category.id)
      ],
    ).card.make();
  }

  startWebFilePicker(CategorySection name, BuildContext context) async {
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
      showMsgAlertAndNamedRoute(
          context, "from start web $e", AdminHome.route, true);
    }
  }

  void _handleResult(
      Object result, CategorySection product, BuildContext context) async {
    try {
      bytesData = Base64Decoder().convert(result.toString().split(",").last);
      selectedFile = bytesData;
      FormData data = FormData.fromMap({
        'imgUrl':
            MultipartFile.fromBytes(bytesData, filename: "${product.name}.png")
      });
      var response = await ApiCalls.productImageUpload(data, product.id,"category");
      print(response);
      showMsgAlertAndNamedRoute(context, response, AdminHome.route, false);
    } catch (e) {
      print(e);
      showMsgAlertAndNamedRoute(
          context, "from _handle $e", AdminHome.route, true);
    }
  }
}
