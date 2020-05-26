import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:ecom_front_end/Sections/Modules.dart';

class CategoryView extends StatelessWidget {
  final CategorySection category;
  final Function callback;

  const CategoryView({Key key, this.category, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: "Name : ${category.name.firstLetterUpperCase()}".text.xl.make(),
      children: [
        callback("category",category.id)
      ],
    ).card.make();
  }
}
