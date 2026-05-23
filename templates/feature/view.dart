import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/common/layouts/page_wrapper.dart';
import 'package:<%= packageName %>/features/<%= featureSnake %>/controllers/<%= featureSnake %>_controller.dart';

class <%= featurePascal %>View extends GetView<<%= featurePascal %>Controller> {
  const <%= featurePascal %>View({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: '<%= featurePascal %>',
      child: const Center(
        child: Text('<%= featurePascal %> feature — start building here.'),
      ),
    );
  }
}
