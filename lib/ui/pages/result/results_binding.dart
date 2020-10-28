import 'package:get/get.dart';
import 'results_controller.dart';

class ResultsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResultsController());
  }
}