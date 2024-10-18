
import 'package:flutter/material.dart';
 import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProductCardWidget extends StatelessWidget {
  final String productTitle;
  final String price;
  final String discountPrice;
  final String imageUrl;
  final String favouriteIcon;
  final Function() wishlistPress;
  final Function() onPress;

  const ProductCardWidget({
    super.key,
    required this.productTitle,
    required this.price,
    required this.discountPrice,
    required this.imageUrl,
    required this.favouriteIcon,
    required this.wishlistPress,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onPress,
      child: SizedBox(
        height: screenWidth * 0.59,
        width: screenWidth * 0.42,
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFDFFFD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  color: const Color(0xffF6F6F6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomSizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              productTitle,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const CustomSizedBox(
                        height: 4,
                      ),
                       Row(
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                                color: Color(0xffA7A5A5),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xffA7A5A5),
                                decorationThickness: 1),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            discountPrice,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: blackColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 12,
              top: 12,
              child: InkWell(
                onTap: wishlistPress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffF6F6F6),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: SvgPicture.asset(
                      favouriteIcon,
                      height: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
