 import 'package:flutter/material.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/ui/cart/qty_counter_widget.dart';
import 'package:shope_ease/widgets/list_view_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';

import '../../theme/theme.dart';

class CartItemList extends StatefulWidget {
  final List<Product> products;
  final HomeBloc homeBloc;

  const CartItemList(
      {super.key, required this.products, required this.homeBloc});

  @override
  State<CartItemList> createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  int itemQty = 0;

  @override
  Widget build(BuildContext context) {
    return ListViewWidget(
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemCount: widget.products?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final cartItem = widget.products[index];
        if (cartItem.cartAdded) {
          return Container(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 12, bottom: 20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      cartItem.image,
                      height: 127,
                      width: 100,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cartItem.name!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff002F36))),
                          Text(
                              "Mandarin Collar Semi Sheer Cotton Printed Casual Shirt",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor.withOpacity(0.5))),
                          const CustomSizedBox(height: 6),
                          Text(cartItem.offerPrice ?? '0',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff002F36))),
                          const CustomSizedBox(height: 6),
                          const Text("Eligible for FREE Shipping",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff002F36))),
                          const CustomSizedBox(height: 6),
                          const Text("In stock",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff22950F))),
                          const CustomSizedBox(height: 6),
                          QtyCounterWidget(
                            itemQty: getQty,
                            homeBloc: widget.homeBloc, onPress: () {
                              widget.homeBloc.add(AddRemoveCartEvent(product: cartItem));
                          },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  getQty(qty) {
    setState(() {
      itemQty = qty;
      print(itemQty.toString());
    });
  }
}
