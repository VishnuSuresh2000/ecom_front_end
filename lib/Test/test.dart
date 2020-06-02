// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:universal_html/prefer_universal/html.dart' as html;
// import 'package:velocity_x/velocity_x.dart';

// class TestBranch extends StatefulWidget {
//   @override
//   _TestBranchState createState() => _TestBranchState();
// }

// class _TestBranchState extends State<TestBranch> {
//   pickImage() {
//     String name = '';
//     String error;
//     Uint8List data;
//     final html.InputElement input = html.document.createElement('input');
//     input
//       ..type = 'file'
//       ..accept = 'image/*';

//     input.onChange.listen((e) {
//       if (input.files.isEmpty) return;
//       final reader = html.FileReader();
//       reader.readAsDataUrl(input.files[0]);
//       reader.onError.listen((err) => setState(() {
//             error = err.toString();
//           }));
//       reader.onLoad.first.then((res) {
//         final encoded = reader.result as String;
//         // remove data:image/*;base64 preambule
//         return encoded;
//       });
//     });

//     input.click();
//   }

//   Image image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: VxBox(
//           child: VStack([
//         RaisedButton(
//           onPressed: () async {
//             print("base64 is encoded and api is calling");
//             try {
//               Map body = <String, dynamic>{"imgB64Data": base64};
//               print("on calling");
//               var res = await http.post("http://localhost:8080/testImage",
//                   headers: {"Content-Type": "application/json"},
//                   body: jsonEncode(body));
//               print("called");
//               print(res.body);
//             } catch (e) {
//               print(e);
//             }
//             if (image != null) {
//               setState(() {});
//             }
//           },
//           child: "Enter the Image".text.make(),
//         ),
//         VxBox(child: image).make()
//       ])).make(),
//     );
//   }
// }
