import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/ui/details_screen/details_appbar.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/rating_wideget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:shope_ease/widgets/widget_border_button.dart';
import 'package:svg_flutter/svg_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        leading: const SizedBox(),
        surfaceTintColor: Colors.white,
      ),
      bottomNavigationBar: addCartButton(screenWidth),
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listener: (context, state) {
            if (state is CartSuccessState) {
              print("Cart updated successfully!");
              homeBloc.add(HomeInitialFetchEvent());
              Widgets().toastWidget("Success", context);
            } else if (state is CartErrorState) {
              print("Error: ${state.error}");
            } else if (state is WishSuccessListState) {
              homeBloc.add(HomeInitialFetchEvent());
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                DetailsAppbar(),
                Stack(
                  children: [
                    SizedBox(
                        height: screenWidth * 0.80,
                        child: SizedBox(
                          width: screenWidth,
                          child: Image.network(widget.product.image),
                        )),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: InkWell(
                        onTap: () {
                          homeBloc.add(AddRemoveFromWishlistEvent(
                              product: widget.product));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffF6F6F6),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Center(
                            child: SvgPicture.asset(
                              widget.product.isWishlist
                                  ? "assets/icons/mdi_heart.svg"
                                  : "assets/icons/mdi_heart-outline.svg",
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const CustomSizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.product.description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const CustomSizedBox(
                        height: 12,
                      ),
                      const Row(
                        children: [
                          Text('Store: Mopio',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              )),
                          Spacer(),
                          const RatingBarWidget(
                            ratingCount: "35",
                            fontSize: 14,
                          ),
                          CustomSizedBox(
                            width: 8,
                          ),
                          Text('Reviews',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      ),
                      const CustomSizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/fast_delivery.svg"),
                          const CustomSizedBox(width: 6),
                          const Text('Free delivery ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff0EB45A))),
                          const CustomSizedBox(width: 6),
                          const Text('September 19 - 23',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: blackColor)),
                        ],
                      ),
                      const CustomSizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.only(
                          right: 20,
                        ),
                        height: 77,
                        width: 77,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8C59C8),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            widget.product.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const CustomSizedBox(
                        height: 18,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: blackColor),
                      ),
                      Text(widget.product.description),
                      const CustomSizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }

  addCartButton(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.product.price + currency,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: greyColor),
              ),
              const Text(
                "-14%",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: redColor),
              ),
            ],
          ),
          const CustomSizedBox(width: 8),
          Text(
            widget.product.offerPrice! + currency,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: blackColor),
          ),
          const Spacer(),
          WidgetBorderButton(
              title: "Qty: 1",
              onPress: () {},
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 12)),
          const CustomSizedBox(width: 8),
          ButtonWidget(
              buttonPress: () {
                homeBloc.add(AddRemoveCartEvent(product: widget.product));
                HapticFeedback.mediumImpact();
              },
              title: 'Add to Cart',
              width: screenWidth * 0.3,
              height: 40,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(1.00, 0.08),
                  end: Alignment(-1, -0.08),
                  colors: [Color(0xFF49108C), Color(0xFF8C59C8)],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 0.09,
              )),
        ],
      ),
    );
  }
}
