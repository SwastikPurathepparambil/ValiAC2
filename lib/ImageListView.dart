import 'package:flutter/material.dart';
import 'package:christa_app/services/scanController.dart';
import 'package:get/get.dart';

class TopImageViewer extends StatelessWidget {
  const TopImageViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ScanController>(
      builder: (controller) => Positioned(
        top: Get.height*0.3,
        left: Get.width*0.3,
        child: SizedBox(
          height: 200,
          width: 300,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.imageList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 200,
                  width: 150,
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(3, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: RepaintBoundary(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(controller.imageList[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              ),
        ),
      ),
    );
  }
}
