import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final Function() onPress;
  final Color viewAllColor;

  const TitleWidget(
      {super.key,
      required this.title,
      required this.onPress,
      this.viewAllColor = const Color(0xff8F959E)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 17,
                color: Color(0xff221F1F),
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onPress,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "View All",
                style: TextStyle(fontSize: 14, color: viewAllColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
