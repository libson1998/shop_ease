import 'package:flutter/material.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/ui/checkout/price_deail_widget.dart';
import 'package:shope_ease/utils/constants.dart';

class PriceDetailsList extends StatelessWidget {
  final List<Product> products;
  final HomeBloc homeBloc;

  const PriceDetailsList(
      {super.key, required this.products, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double totalOfferPrice = 0.0;
    double discount = 0.0;
    double totalAmt = 0.0;
    for (var product in products) {
      if (product.cartAdded) {
        final productPrice = double.tryParse(product.price ?? '0') ?? 0.0;
        final productOfferPrice =
            double.tryParse(product.offerPrice ?? '0') ?? 0.0;

        totalOfferPrice += productPrice;
        discount += (productPrice - productOfferPrice);
      }
    }
    totalAmt = totalOfferPrice - discount;

    return Container(
      padding: const EdgeInsets.all(20),
      width: screenWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Price details(${products.length})",
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: blackColor)),
          const Divider(
            color: Color(0xffF6F6F6),
            thickness: 1,
          ),
          PriceDetailWidget(
              title: "Total MRP",
              strValue: totalOfferPrice.toString() + currency),
          PriceDetailWidget(
              title: "Discount",
              strValue: discount.toString() + currency,
              color: Colors.blue),
          const PriceDetailWidget(
              title: "Coupon Discount", strValue: "0$currency"),
          const PriceDetailWidget(
              title: "Delivery Charge", strValue: "", isShow: true),
          PriceDetailWidget(
              title: "Total MRP",
              strValue: totalAmt.toString() + currency,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ],
      ),
    );
  }
}
