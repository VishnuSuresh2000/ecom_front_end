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
          "Name : ${commonProfile.fullName.firstLetterUpperCase()}".text.xl.make(),
      children: [
        ListTile(
          title: "Sex\t:\t${commonProfile.sex?'Male':'Female'}".text.make(),
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
        ListTile(
          title: "HouseName\t:\t${commonProfile.address.houseName}".text.make(),
        ),
        ListTile(
          title: "Locality\t:\t${commonProfile.address.locality}".text.make(),
        ),
        ListTile(
          title: "City \t:\t${commonProfile.address.city}".text.make(),
        ),
        ListTile(
          title: "District \t:\t${commonProfile.address.district}".text.make(),
        ),
        ListTile(
          title: "State \t:\t${commonProfile.address.state}".text.make(),
        ),
        ListTile(
          title: "Pincode \t:\t${commonProfile.address.pinCode}".text.make(),
        ),
        ListTile(
          title: "Alternate Phone Number \t:\t${commonProfile.address.alternateNumber}".text.make(),
        ),
        callback("commonProfile", commonProfile.id)
      ],
    ).card.make();
  }
}
