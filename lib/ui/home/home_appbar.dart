import 'package:flutter/material.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 93,
            child: Text(
              "DemoApp",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 20),
            ),
          ),
          const Spacer(),

          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/NotificationScreen");
            },
            child: Stack(
              children: [
                SvgPicture.asset("assets/icons/Bell.svg"),
                Positioned(
                  left: 11,
                  top: 0,
                  child: Container(
                    width: 13,
                    height: 13,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFDA0000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '0',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
