import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shope_ease/theme/theme.dart';

class DiscountBanner extends StatefulWidget {
  const DiscountBanner({
    super.key,
  });

  @override
  State<DiscountBanner> createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  int activeIndex = 0;
  final List<ImageModel> images = [
    ImageModel(
      id: 2,
      imageUrl: 'assets/images/banner_im.jpg',
    ),
    ImageModel(
      id: 1,
      imageUrl: 'assets/images/banner.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      width: screenWidth,
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return Image.asset(
                images[index].imageUrl.toString(),
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            bottom: 0,
            right: 150,
            left: 150,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: greyColor.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            border: Border.all(color: greyColor),
                            shape: BoxShape.circle,
                            color: index == activeIndex
                                ? Colors.white
                                : greyColor.withOpacity(0.2),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
// CachedNetworkImage(
// imageUrl: widget.homeSlider![index].image.toString(),
// fit: BoxFit.fill,
// width: MediaQuery.of(context).size.width,
// height: screenWidth * 0.5,
// placeholder: (context, url) => Image.asset(
// 'assets/images/no_image.jpg',
// height: 100,
// width: 100,
// fit: BoxFit.contain,
// ),
// errorWidget: (context, url, error) => Image.asset(
// 'assets/images/no_image.jpg',
// height: 100,
// width: 100,
// fit: BoxFit.contain,
// ),
// );

class ImageModel {
  final int id;
  final String imageUrl;

  ImageModel({
    required this.id,
    required this.imageUrl,
  });
}
