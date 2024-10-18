import 'package:flutter/material.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OrderSuccessScreen extends StatelessWidget {
  final Function(int) navigateTo;

  const OrderSuccessScreen({super.key, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              navigateTo(0);
            },
            icon: Icon(Icons.keyboard_arrow_left_rounded),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          titleSpacing: 0,
          title: const Text(
            "Order Placed",
            style: TextStyle(fontSize: 14),
          )),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffFDFFFD),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/icons/check.svg"),
                      const CustomSizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Your order has been placed",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                                "Mandarin Collar Semi Sheer Cotton Printed Casual Shirt",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff0F041C))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const CustomSizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffFDFFFD),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "We sent an email to orders@random.com with your order confirmation and bill. ",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                      CustomSizedBox(height: 14),
                      Text("Time placed: 04/03/2024 12:45",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0F041C))),
                    ],
                  ),
                ),
                const CustomSizedBox(height: 18),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Items",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Track your order",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const CustomSizedBox(height: 15),
                Container(
                  width: 343,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/icons/truck.svg"),
                        const CustomSizedBox(width: 8),
                        const Text("Arrives by April 3 to April 9th",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ]),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
