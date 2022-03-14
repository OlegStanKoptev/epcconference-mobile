import 'package:flutter/material.dart';

typedef CommonSliverPersistentHeaderDelegateBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class CommonSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final double height;
  final CommonSliverPersistentHeaderDelegateBuilder builder;

  CommonSliverPersistentHeaderDelegate({
    required this.builder,
    required this.height
  });

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  bool shouldRebuild(CommonSliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
