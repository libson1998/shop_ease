import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/ui/cart/cart_item_list.dart';
import 'package:shope_ease/ui/checkout/price_details_widget.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/change_adddress_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';

class CartScreen extends StatefulWidget {
  final Function(int) navigateTo;

  const CartScreen({super.key, required this.navigateTo});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is CartSuccessState) {
          context.read<HomeBloc>().add(HomeInitialFetchEvent());
        }
      },
      builder: (context, state) {
        int listCount = 0;

        if (state is HomeSuccessState) {
          listCount = state.products
              .where((product) => product.cartAdded == true)
              .length;

          if (listCount == 0) {
            return Scaffold(
              backgroundColor: const Color(0xffF6F6F6),
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                toolbarHeight: 20,
                leading: const SizedBox(),
              ),
              body: const Center(child: Text("Cart is Empty!")),
            );
          }

          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).popUntil((route) => route.isFirst);
              widget.navigateTo(0);
              return false;
            },
            child: Scaffold(
              backgroundColor: const Color(0xffF6F6F6),
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                toolbarHeight: 20,
                leading: const SizedBox(),
              ),
              bottomNavigationBar: listCount == 0
                  ? const SizedBox()
                  : bottomBar(screenWidth, state.products),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PreferredSize(
                        preferredSize:
                            Size.fromHeight(AppBar().preferredSize.height),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 32),
                          color: Colors.white,
                          child: Row(
                            children: [
                              const Text(
                                "Cart",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const CustomSizedBox(width: 4),
                              Text(
                                "($listCount items)",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const CustomSizedBox(height: 4),
                      ChangeAddressWidget(onPress: () {}),
                      const CustomSizedBox(height: 40),
                      CartItemList(
                        products: state.products,
                        homeBloc: homeBloc,
                      ),
                      PriceDetailsList(
                        products: state.products,
                        homeBloc: homeBloc,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Widgets().widgetLoader();
        }
      },
    );
  }

  bottomBar(double screenWidth, List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
      child: Container(
        color: Colors.white,
        child: ButtonWidget(
          isLeftIconVisible: true,
          buttonPress: () {
            Navigator.pushNamed(context, "/CheckoutScreen",
                arguments: [products, homeBloc]);
          },
          title: 'Proceed to Checkout',
          width: screenWidth,
          height: 40,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.08),
              end: Alignment(-1, -0.08),
              colors: [Color(0xFF49108C), Color(0xFF8C59C8)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0.09,
          ),
          isRightIconVisible: true,
        ),
      ),
    );
  }
}
