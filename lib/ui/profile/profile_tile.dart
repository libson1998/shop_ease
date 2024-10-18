
import 'package:flutter/material.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileTile extends StatelessWidget {
  final String strIcon;
  final String title;
  final Function() onPress;
  final bool? showPadding;

  final Color? textColor;

  const ProfileTile(
      {super.key,
      required this.strIcon,
      required this.title,
      required this.onPress,
      this.textColor = blackColor,
      this.showPadding = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: showPadding! ? 12 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(strIcon),
                  const CustomSizedBox(
                    width: 14,
                  ),
                  Text(title,
                      style: TextStyle(fontSize: 12, color: textColor)),
                ],
              ),
              SvgPicture.asset(
                "assets/icons/select.svg",
                color: textColor,
              ),
            ],
          )),
    );
  }
}
