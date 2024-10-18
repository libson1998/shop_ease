import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/ui/cart/cart_item_list.dart';
import 'package:shope_ease/ui/checkout/price_deail_widget.dart';
import 'package:shope_ease/ui/checkout/price_details_widget.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/change_adddress_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Product> products;
  final HomeBloc homeBloc;

  const CheckoutScreen(
      {super.key, required this.products, required this.homeBloc});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: widget.homeBloc,
      builder: (context, state) {
        List<Product> currentProducts = widget.products;

        if (state is HomeSuccessState) {
          currentProducts = state.products
              .where((product) => product.cartAdded == true)
              .toList();
        }

        return Scaffold(
          backgroundColor: const Color(0xffF6F6F6),
          bottomNavigationBar: continueButton(screenWidth, currentProducts),
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            toolbarHeight: 20,
            leading: const SizedBox(),
          ),
          body: SafeArea(
            child: Column(
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(AppBar().preferredSize.height),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 32),
                    color: Colors.white,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/arrow_Left.svg',
                            height: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Order summary",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const CustomSizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ChangeAddressWidget(onPress: () {}),
                        CartItemList(
                          products: currentProducts,
                          homeBloc: widget.homeBloc,
                        ),
                        const CustomSizedBox(height: 20),
                        PriceDetailsList(
                            products: currentProducts,
                            homeBloc: widget.homeBloc),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  continueButton(double screenWidth, List<Product> products) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ButtonWidget(
        buttonPress: () {
          Navigator.popAndPushNamed(context, "/OrderSuccessScreen");
        },
        title: "Continue",
        width: screenWidth,
        height: 50,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, 0.08),
            end: Alignment(-1, -0.08),
            colors: [Color(0xFF49108C), Color(0xFF8C59C8)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 0.09,
        ),
      ),
    );
  }
}
