import 'package:christa_app/screens/MoodBoardScreen.dart';
import 'package:christa_app/screens/emotionResultScreen.dart';
import 'package:christa_app/services/scanController.dart';
import 'package:flutter/material.dart';
import 'package:christa_app/services/scanController.dart';
import 'package:get/get.dart';



class CaptureButton extends GetView<ScanController> {
  const CaptureButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}