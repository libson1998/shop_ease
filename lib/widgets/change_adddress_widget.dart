import 'package:flutter/material.dart';
 import 'package:shope_ease/theme/theme.dart';

class ChangeAddressWidget extends StatelessWidget {

  final Function()onPress;
  const ChangeAddressWidget({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return             Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          const Text("Check delivery address",
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.normal)),
          const Spacer(),
          InkWell(
            onTap: onPress,
            child: const Text("Change",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: redColor)),
          ),
        ],
      ),
    );

  }
}
