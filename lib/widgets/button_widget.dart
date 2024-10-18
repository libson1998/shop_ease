
import 'package:flutter/material.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() buttonPress;
  final double? width;
  final double? height;
  final Decoration? decoration;
  final String title;
  final TextStyle? textStyle;
  final bool isRightIconVisible;
  final bool isLeftIconVisible;
  final String? icon;
  final bool isLoading;

  const ButtonWidget(
      {super.key,
      required this.buttonPress,
      this.width,
      this.height,
      this.decoration,
      required this.title,
      this.textStyle,
      this.isRightIconVisible = false,
      this.isLeftIconVisible = false,
      this.icon = "assets/icons/basket.svg",
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonPress,
      child: isLoading
          ? Container(
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:blackColor.withOpacity(0.2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Widgets().widgetLoader()],
              ),
            )
          : Container(
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: decoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isLeftIconVisible
                      ? Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 4),
                          child: SvgPicture.asset(
                            icon!,
                            height: 24,
                            width: 24,
                          ),
                        )
                      : const CustomSizedBox(),
                  Text(title, textAlign: TextAlign.center, style: textStyle),
                  isRightIconVisible
                      ? Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: SvgPicture.asset(
                            'assets/icons/basket.svg',
                            height: 24,
                            width: 24,
                          ),
                        )
                      : const CustomSizedBox()
                ],
              ),
            ),
    );
  }
}
