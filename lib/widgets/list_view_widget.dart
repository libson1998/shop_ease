import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool shrinkWrap;
  final ScrollPhysics? scrollPhysics;
  final Axis scrollDirection;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;

  const ListViewWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.shrinkWrap = true,
    this.scrollPhysics,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: scrollPhysics,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      padding: padding,
    );
  }
}
