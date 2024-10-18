import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/ui/home/home_appbar.dart';
import 'package:shope_ease/ui/home/home_slider.dart';
import 'package:shope_ease/ui/home/product_grid.dart';
import 'package:shope_ease/ui/home/search_form_button.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:shope_ease/widgets/widget_title.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) navigateTo;

  const HomeScreen({super.key, required this.navigateTo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const SizedBox(),
          surfaceTintColor: Colors.white,
          toolbarHeight: 0),
      body: SafeArea(
          child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is WishSuccessListState) {
            homeBloc.add(HomeInitialFetchEvent());
            Widgets().toastWidget("Success", context);
          }
        },
        builder: (context, state) {
          if (state is HomeSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(
                        children: [
                          const CustomSizedBox(
                            height: 20,
                          ),
                          const HomeAppBar(),
                          const CustomSizedBox(
                            height: 16,
                          ),
                          const CustomSizedBox(height: 16),
                          SearchFormButton(
                            products: state.products,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const CustomSizedBox(
                    height: 20,
                  ),
                  const DiscountBanner(),
                  TitleWidget(title: "Top Selling Products", onPress: () {}),
                  ProductGrid(
                    navigateTo: widget.navigateTo,
                    products: state.products,
                    homeBloc: homeBloc,
                  ),
                  Image.asset("assets/images/image_banner.jpg"),

                  TitleWidget(title: "Top Selling Products", onPress: () {}),
                  ProductGrid(
                    navigateTo: widget.navigateTo,
                    products: state.products!,
                    homeBloc: homeBloc,
                  ),
                ],
              ),
            );
          } else {
            return Widgets().widgetLoader();
          }
        },
      )),
    );
  }
}
