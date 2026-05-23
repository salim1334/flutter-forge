import 'package:flutter/material.dart';
import 'package:<%= packageName %>/core/constants/app_sizes.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({
    required this.child,
    super.key,
    this.title,
    this.actions,
    this.padding = true,
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(title: Text(title!), actions: actions)
          : null,
      body: SafeArea(
        child: Padding(
          padding: padding
              ? const EdgeInsets.all(AppSizes.defaultPadding)
              : EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
