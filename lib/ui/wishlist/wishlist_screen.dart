import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/list_view_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class WishlistScreen extends StatefulWidget {
  final Function(int) navigateTo;

  const WishlistScreen({super.key, required this.navigateTo});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    homeBloc =
        BlocProvider.of<HomeBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        widget.navigateTo(0);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          toolbarHeight: 20,
          leading: SizedBox(),
        ),
        body: SafeArea(
            child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is WishSuccessListState) {
              homeBloc.add(HomeInitialFetchEvent());
              Widgets().toastWidget("Success", context);
            } else if (state is CartSuccessState) {
              homeBloc.add(HomeInitialFetchEvent());
              Widgets().toastWidget("Success", context);
            }
          },
          builder: (context, state) {
            if (state is HomeSuccessState) {
              int listCount = state.products
                  .where((product) => product.isWishlist == true)
                  .length;
              if(listCount==0){
                return Center(child: Text("Empty Wishlist"!));
              }else{
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                const Text("Wishlist",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const CustomSizedBox(width: 4),
                                Text("($listCount items)",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: blackColor.withOpacity(0.5))),
                              ],
                            ),
                          )),
                      const CustomSizedBox(
                        height: 2,
                      ),
                      ListViewWidget(
                        shrinkWrap: true,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        itemCount: state.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          final wishlistProduct = state.products[index];

                          if (wishlistProduct.isWishlist) {
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
                                        wishlistProduct.image,
                                        height: 127,
                                        width: 100,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(wishlistProduct.name!,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff002F36))),
                                            Text(
                                                "Mandarin Collar Semi Sheer Cotton Printed Casual Shirt",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: blackColor
                                                        .withOpacity(0.5))),
                                            const CustomSizedBox(height: 6),
                                            Text(wishlistProduct.description,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff002F36))),
                                            const CustomSizedBox(height: 6),
                                            const Text(
                                                "Eligible for FREE Shipping",
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
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ButtonWidget(
                                                      buttonPress: () {
                                                        homeBloc.add(
                                                            AddRemoveCartEvent(
                                                                product:
                                                                wishlistProduct));
                                                      },
                                                      title: 'Add to Cart',
                                                      width: screenWidth * 0.3,
                                                      height: 40,
                                                      decoration: ShapeDecoration(
                                                        gradient:
                                                        const LinearGradient(
                                                          begin: Alignment(
                                                              1.00, 0.08),
                                                          end: Alignment(
                                                              -1, -0.08),
                                                          colors: [
                                                            Color(0xFF49108C),
                                                            Color(0xFF8C59C8)
                                                          ],
                                                        ),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8)),
                                                      ),
                                                      textStyle: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        height: 0.09,
                                                      )),
                                                ),
                                                const CustomSizedBox(width: 10),
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      homeBloc.add(
                                                          AddRemoveFromWishlistEvent(
                                                              product:
                                                              wishlistProduct));
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: screenWidth * 0.3,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      decoration: ShapeDecoration(
                                                        color: const Color(
                                                            0xFFFFE9EC),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8)),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/icons/trash.svg"),
                                                          const Text("Remove",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                                  color:
                                                                  redColor)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
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
                      ),
                      // ListViewWidget(
                      //   shrinkWrap: true,
                      //   scrollPhysics: const NeverScrollableScrollPhysics(),
                      //   itemCount: state.sales!.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     final wishlistSales = state.sales![index];
                      //     if (wishlistSales['isWishlist']) {
                      //       return Container(
                      //         padding: const EdgeInsets.only(
                      //             left: 20.0, right: 20.0, top: 12, bottom: 20),
                      //         color: Colors.white,
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.start,
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Image.network(
                      //                   wishlistSales['image'],
                      //                   height: 127,
                      //                   width: 100,
                      //                 ),
                      //                 Expanded(
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       Text(wishlistSales['name'],
                      //                           style: const TextStyle(
                      //                               fontSize: 14,
                      //                               fontWeight: FontWeight.w500,
                      //                               color: Color(0xff002F36))),
                      //                       Text(
                      //                           "Mandarin Collar Semi Sheer Cotton Printed Casual Shirt",
                      //                           style: TextStyle(
                      //                               fontSize: 14,
                      //                               fontWeight: FontWeight.w500,
                      //                               color: blackColor
                      //                                   .withOpacity(0.5))),
                      //                       const CustomSizedBox(height: 6),
                      //                       Text(wishlistSales['description'],
                      //                           style: const TextStyle(
                      //                               fontSize: 16,
                      //                               fontWeight: FontWeight.w500,
                      //                               color: Color(0xff002F36))),
                      //                       const CustomSizedBox(height: 6),
                      //                       const Text(
                      //                           "Eligible for FREE Shipping",
                      //                           style: TextStyle(
                      //                               fontSize: 13,
                      //                               fontWeight: FontWeight.w400,
                      //                               color: Color(0xff002F36))),
                      //                       const CustomSizedBox(height: 6),
                      //                       const Text("In stock",
                      //                           style: TextStyle(
                      //                               fontSize: 13,
                      //                               fontWeight: FontWeight.w400,
                      //                               color: Color(0xff22950F))),
                      //                       const CustomSizedBox(height: 6),
                      //                       Row(
                      //                         children: [
                      //                           Expanded(
                      //                             child: ButtonWidget(
                      //                                 buttonPress: () {},
                      //                                 title: 'Add to Cart',
                      //                                 width: screenWidth * 0.3,
                      //                                 height: 40,
                      //                                 decoration: ShapeDecoration(
                      //                                   gradient:
                      //                                       const LinearGradient(
                      //                                     begin: Alignment(
                      //                                         1.00, 0.08),
                      //                                     end: Alignment(
                      //                                         -1, -0.08),
                      //                                     colors: [
                      //                                       Color(0xFF49108C),
                      //                                       Color(0xFF8C59C8)
                      //                                     ],
                      //                                   ),
                      //                                   shape:
                      //                                       RoundedRectangleBorder(
                      //                                           borderRadius:
                      //                                               BorderRadius
                      //                                                   .circular(
                      //                                                       8)),
                      //                                 ),
                      //                                 textStyle: const TextStyle(
                      //                                   color: Colors.white,
                      //                                   fontSize: 12,
                      //                                   fontFamily: 'Inter',
                      //                                   fontWeight:
                      //                                       FontWeight.w600,
                      //                                   height: 0.09,
                      //                                 )),
                      //                           ),
                      //                           const CustomSizedBox(width: 10),
                      //                           Expanded(
                      //                             child: Container(
                      //                               height: 40,
                      //                               width: screenWidth * 0.3,
                      //                               padding: const EdgeInsets
                      //                                   .symmetric(
                      //                                   horizontal: 10),
                      //                               decoration: ShapeDecoration(
                      //                                 color:
                      //                                     const Color(0xFFFFE9EC),
                      //                                 shape:
                      //                                     RoundedRectangleBorder(
                      //                                         borderRadius:
                      //                                             BorderRadius
                      //                                                 .circular(
                      //                                                     8)),
                      //                               ),
                      //                               child: Row(
                      //                                 crossAxisAlignment:
                      //                                     CrossAxisAlignment
                      //                                         .center,
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment
                      //                                         .center,
                      //                                 children: [
                      //                                   SvgPicture.asset(
                      //                                       "assets/icons/trash.svg"),
                      //                                   const Text("Remove",
                      //                                       style: TextStyle(
                      //                                           fontSize: 12,
                      //                                           fontWeight:
                      //                                               FontWeight
                      //                                                   .w400,
                      //                                           color: redColor)),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     } else {
                      //       return const SizedBox();
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                );

              }
            } else {
              return Widgets().widgetLoader();
            }
          },
        )),
      ),
    );
  }
}
