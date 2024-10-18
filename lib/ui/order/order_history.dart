import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/form_widget.dart';
import 'package:shope_ease/widgets/list_view_widget.dart';
import 'package:shope_ease/widgets/rating_wideget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String strSearchInput = "";
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 20,
        surfaceTintColor: Colors.white,
        leading: const SizedBox(),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is WishSuccessListState) {
            homeBloc.add(HomeInitialFetchEvent());
            Widgets().toastWidget("Success", context);
          }
        },
        builder: (context, state) {
          if (state is HomeSuccessState) {
            return SafeArea(
                child: Column(
              children: [
                PreferredSize(
                    preferredSize:
                        Size.fromHeight(AppBar().preferredSize.height),
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      color: Colors.white,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                  'assets/icons/arrow_Left.svg',
                                  height: 24)),
                          const SizedBox(width: 12),
                          const Text("Order History",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: FormFieldWidget(
                                passwordObscure: false,
                                isIconVisible: true,
                                initialValue: strSearchInput,
                                onSave: (newValue) {
                                  strSearchInput = newValue!;
                                },
                                onChange: (value) {
                                  strSearchInput = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field cannot be empty";
                                  } else if (value.length > 9) {
                                    return "Please enter valid mobile number";
                                  }
                                  return null;
                                },
                                hintText: "Search orders",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: blackColor, width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: secondaryColor, width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                errorBorder: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                iconColor: kPrimaryColor,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: SvgPicture.asset(
                                      "assets/icons/search.svg"),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff7A7979),
                                    fontWeight: FontWeight.w500),
                                labelStyle: const TextStyle(
                                    fontSize: 14, color: textColor),
                                child: const SizedBox()),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Filter",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: blackColor)),
                                CustomSizedBox(width: 16),
                                Icon(Icons.filter_list, color: blackColor),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ListViewWidget(
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final productList = state.products[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: productList.purchaseCompleted?Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Image.network(productList.image,
                                        height: screenWidth * 0.30),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  "/OrderTrackingScreen",
                                                  arguments: [productList]);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(productList.name!,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: blackColor)),
                                                    const Spacer(),
                                                    const Icon(Icons
                                                        .keyboard_arrow_right)
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.55,
                                                  child: const Text(
                                                    "Mandarin Collar Semi Sheer Cotton Printed Casual Shirt",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0xff002F36)),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const CustomSizedBox(
                                            height: 14,
                                          ),
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            onTap: () {},
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Rate your order now",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0xff002F36))),
                                                CustomSizedBox(
                                                  height: 4,
                                                ),
                                                RatingBarWidget(
                                                  ratingCount: "",
                                                  iconSize: 22,
                                                  isShowRatingText: false,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: greyColor,
                                thickness: 0.5,
                              )
                            ],
                          ):SizedBox(),
                        );
                      },
                    )
                  ],
                ),
              ],
            ));
          } else {
            return Widgets().widgetLoader();
          }
        },
      ),
    );
  }
}
