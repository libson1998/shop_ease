import 'package:flutter/material.dart';

class WidgetBorderButton extends StatelessWidget {
  final String title;
  final Function() onPress;
  final EdgeInsetsGeometry? padding;

  const WidgetBorderButton(
      {super.key,
      required this.title,
      required this.onPress,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: padding,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0x33002F36)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF002F36),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
            height: 0.06,
          ),
        ),
      ),
    );
  }
}
