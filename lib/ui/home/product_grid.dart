import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/ui/home/product_card.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/list_view_widget.dart';

class ProductGrid extends StatelessWidget {
  final Function(int) navigateTo;
  final List<Product> products;
  final HomeBloc homeBloc;

  const ProductGrid({
    super.key,
    required this.navigateTo,
    required this.products,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
      height: 250,
      child: ListViewWidget(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          final product = products[index];

          return Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: ProductCardWidget(
              productTitle: product.name!,
              price: product.price,
              discountPrice: product.offerPrice!,
              wishlistPress: () async {
                homeBloc.add(AddRemoveFromWishlistEvent(product: product));
              },
              onPress: () {
                Navigator.pushNamed(
                  context,
                  "/DetailsScreen",
                  arguments: [product, navigateTo],
                );
              },
              imageUrl: product.image,
              favouriteIcon: product.isWishlist
                  ? "assets/icons/mdi_heart.svg"
                  : "assets/icons/mdi_heart-outline.svg",
            ),
          );
        },
      ),
    ));
  }
}
