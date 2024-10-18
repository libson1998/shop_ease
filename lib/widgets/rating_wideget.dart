 import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class RatingBarWidget extends StatelessWidget {
  final double rating;
  final double iconSize;
  final String ratingCount;
  final double fontSize;
  final bool isShowRatingText;

  const RatingBarWidget(
      {super.key,
      this.rating = 2.75,
      this.iconSize = 14,
      required this.ratingCount,
      this.fontSize = 10,
      this.isShowRatingText = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: 2.75,
          itemBuilder: (context, index) =>   SvgPicture.asset(
           "assets/icons/star.svg",
            color:const Color(0xff0EB45A),
          ),
          itemCount: 5,
          itemSize: iconSize,
          direction: Axis.horizontal,
        ),
        const CustomSizedBox(width: 8),
        isShowRatingText
            ? Text(ratingCount,
                style: TextStyle(
                    fontSize: fontSize, color: const Color(0xff221F1F)))
            : const SizedBox(),
      ],
    );
  }
}
