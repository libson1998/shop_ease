import 'package:flutter/material.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';

class PriceDetailWidget extends StatelessWidget {
  final FontWeight? fontWeight;
  final String title;
  final String strValue;
  final Color? color;
  final bool isShow;
  final double fontSize;

  const PriceDetailWidget(
      {super.key,
      this.fontWeight = FontWeight.w400,
      required this.title,
      required this.strValue,
      this.color = blackColor,
      this.isShow = false,
      this.fontSize = 13});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 13, fontWeight: fontWeight, color: blackColor)),
          const Spacer(),
          isShow
              ? Row(
                  children: [
                    Text("Free",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: fontWeight,
                            color: Colors.green)),
                  ],
                )
              : const SizedBox(),
          Text(strValue,
              style: TextStyle(
                  fontSize: fontSize, fontWeight: fontWeight, color: color)),
        ],
      ),
    );
  }
}
