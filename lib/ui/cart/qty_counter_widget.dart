import 'package:flutter/material.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class QtyCounterWidget extends StatefulWidget {
  final Function(int) itemQty;
  final HomeBloc homeBloc;
  final Function() onPress;

  const QtyCounterWidget({
    super.key,
    required this.itemQty,
    required this.homeBloc,
    required this.onPress,
  });

  @override
  State<QtyCounterWidget> createState() => _QtyCounterWidgetState();
}

class _QtyCounterWidgetState extends State<QtyCounterWidget> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          height: 35,
          width: screenWidth * 0.3,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEDEDED)),
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFEDEDED),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (qty > 1) {
                    setState(() {
                      qty--;
                      widget.itemQty(qty);
                    });
                  }
                },
                child: const Icon(Icons.remove),
              ),
              Container(
                color: Colors.white,
                height: 35,
                width: 40,
                child: Center(
                  child: Text(
                    qty.toString().padLeft(2, '0'),
                    // Display the current quantity
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: blackColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    qty++;
                    widget.itemQty(qty);
                  });
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const CustomSizedBox(width: 10),
        Expanded(
          child: Container(
            height: 35,
            width: screenWidth * 0.3,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: ShapeDecoration(
              color: const Color(0xFFFFE9EC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: GestureDetector(
              onTap: widget.onPress,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/trash.svg"),
                  const CustomSizedBox(width: 8),
                  const Text(
                    "Remove",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: redColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
