import 'package:camera/camera.dart';
import 'package:christa_app/ImageListView.dart';
import 'package:christa_app/screens/emotionResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:christa_app/cameraViewer.dart';
import 'package:christa_app/captureButton.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../services/scanController.dart';



class CameraScreen extends GetView<ScanController> {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ScanController>(builder: (controller) {
      if (!controller.isInitialized) {
        controller.onInit();
        return Container();
      }
      return Stack(
        alignment: Alignment.center,
        children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: CameraPreview(controller.cameraController)
            ),
            Positioned(
              bottom: 30,
              child: GestureDetector(
                onTap: ()  {
                  controller.capture(context);
                  // controller.dispose();
                  // HAVE TO GO FROM ONE PAGE TO THE NEXT:
                  //https://www.youtube.com/watch?v=RaqPIoJSTtI
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EmotionDetectionScreen())
                  );
                  controller.dispose();
                  // print(controller);
                  // print(controller.currLabel);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white, width: 5)
                  ),
                  child: Visibility(
                    visible: controller.imageList.length < 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(Icons.camera, size: 60,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}