<% if (withBinding) { %>
import 'package:get/get.dart';
import 'package:<%= packageName %>/features/<%= featureSnake %>/controllers/<%= featureSnake %>_controller.dart';

class <%= featurePascal %>Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(<%= featurePascal %>Controller.new);
  }
}
<% } %>
