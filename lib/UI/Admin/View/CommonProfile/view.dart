import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
class CommonProfileView extends StatelessWidget {
  final CommonProfile commonProfile;
  final Function callback;

  const CommonProfileView({Key key, this.commonProfile, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: "Name : ${commonProfile.name.firstLetterUpperCase()}".text.xl.make(),
      children: [
        ListTile(
          title: "Address\t:\t${commonProfile.address}".text.make(),
        ),
         ListTile(
          title: "Phone Number\t:\t${commonProfile.phoneNumber}".text.make(),
        ),
       
        ListTile(
          title: "Email\t:\t${commonProfile.email}".text.make(),
        ),
        ListTile(
          title: "IsVerified\t:\t${commonProfile.isVerified}".text.make(),
        ),
        callback("commonProfile",commonProfile.id)
      ],
    ).card.make();
  }
}