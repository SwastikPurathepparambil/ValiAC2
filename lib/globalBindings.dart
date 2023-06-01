// import 'package:flutter_camera/scan_controller.dart';
import 'package:christa_app/services/scanController.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ScanController>(ScanController());
  }
}