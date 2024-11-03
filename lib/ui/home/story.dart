import 'package:flutter/material.dart';
import 'package:shope_ease/network/model_class/HomeFeedsModel.dart';

class CircularContainerWithBorder extends StatelessWidget {
  final double size;
  final double borderWidth;
  final Color borderColor;
  final HomeFeedsModel homeFeedsList;

  const CircularContainerWithBorder({
    super.key,
    this.size = 50.0, // default size
    this.borderWidth = 2.0, // default border width
    this.borderColor = Colors.blue, // default border color
    required this.homeFeedsList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(
                  borderRadius: BorderRadius.circular(50),

                  border: Border.all(color: Colors.redAccent,width: 3)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              homeFeedsList.imageUrl,
              fit: BoxFit.cover,
              width: 70, // Ensure the image matches the container size
              height: 70,
            ),
          ),
        ),
      ],
    );
  }
}
