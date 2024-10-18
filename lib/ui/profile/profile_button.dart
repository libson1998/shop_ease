import 'package:flutter/material.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileButtonWidget extends StatelessWidget {
  final String title;
  final String imageurl;
  final Color buttonColor;
  final Function() onPress;
  final int flex;

  const ProfileButtonWidget(
      {super.key,
      required this.title,
      required this.imageurl,
      required this.onPress,
      this.buttonColor = Colors.white,
      this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: buttonColor),
          child: Row(
            children: [
              const CustomSizedBox(width: 12),
              SvgPicture.asset(imageurl),
              const CustomSizedBox(width: 12),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
