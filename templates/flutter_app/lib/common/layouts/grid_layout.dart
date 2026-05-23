import 'package:flutter/material.dart';
import 'package:<%= packageName %>/core/constants/app_sizes.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({
    required this.itemCount,
    required this.itemBuilder,
    super.key,
    this.crossAxisCount = 2,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSizes.md,
        mainAxisSpacing: AppSizes.md,
        childAspectRatio: 1.2,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
