import 'package:ecom_front_end/Sections/Channels.dart';
import 'package:ecom_front_end/Sections/Modules.dart';
import 'package:ecom_front_end/UI/Admin/CustomSection.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CommonProfileView extends StatelessWidget {
  final CommonProfile commonProfile;
  final Function callback;
  final apiNames api;

  const CommonProfileView(
      {Key key, this.commonProfile, this.callback, this.api})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title:
          "Name : ${commonProfile.name.firstLetterUpperCase()}".text.xl.make(),
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
          trailing: verifiedButton(
              context,
              ApiNames.getApiNames(api),
              commonProfile.id,
              commonProfile.isVerified == null
                  ? false
                  : commonProfile.isVerified),
        ),
        callback("commonProfile", commonProfile.id)
      ],
    ).card.make();
  }
}
