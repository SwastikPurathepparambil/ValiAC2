import 'dart:typed_data';
import 'package:christa_app/providers/ImageProvider.dart';
import 'package:christa_app/screens/emotionResultScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;


class ScanController extends GetxController {

  late List<CameraDescription> _cameras;
  late CameraController _cameraController;
  final RxBool _isInitialized = RxBool(false);
  CameraImage? _cameraImage;
  final RxList<Uint8List> _imageList = RxList([]);
  int imageCount = 0;
  String currLabel = "";
  CameraImage? currImage;


  CameraController get cameraController => _cameraController;
  bool get isInitialized => _isInitialized.value;
  List<Uint8List> get imageList => _imageList;


  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<void> initTflite() async {
    String? res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
        numThreads: 1, // defaults to 1
        isAsset: true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[1], ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.bgra8888);
    _cameraController.initialize().then((value) {
      _isInitialized.value = true;

      _cameraController.startImageStream((image){

          _cameraImage = image;
          currImage = image;
          imageCount++;
          if (imageCount % 15 == 0) {
            imageCount = 0;
            objectRecognition(image);
          }

      //   _cameraImage = image
      });

      _isInitialized.refresh();
    })
        .catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void onInit() {
    initCamera();
    initTflite();
    super.onInit();
  }

  Future<void> objectRecognition(CameraImage cameraImage) async {
    var recognitions = await Tflite.runModelOnFrame(
        bytesList: cameraImage.planes.map((plane) {return plane.bytes;}).toList(),// required
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        imageMean: 127.5,   // defaults to 127.5
        imageStd: 127.5,    // defaults to 127.5
        rotation: 90,       // defaults to 90, Android only
        numResults: 2,      // defaults to 5
        threshold: 0.1,     // defaults to 0.1
        asynch: true        // defaults to true
    );
    if (recognitions != null) {
      print("Recognition: $recognitions");
      if (recognitions[0]["confidence"] > 0.75) {
        currLabel = recognitions[0]['label'].split(' ')[1];
      }
    }

  }

  void capture(BuildContext context) {
    print("Capture Starting");
    if (_cameraImage != null) {
      img.Image image = img.Image.fromBytes(
          _cameraImage!.width,  _cameraImage!.height,
          _cameraImage!.planes[0].bytes, format: img.Format.bgra);
      Uint8List list = Uint8List.fromList(img.encodeJpg(image));
      Provider.of<ImageProviderModel>(context, listen: false).setImage(list);
      Provider.of<ImageProviderModel>(context, listen: false).setLabel(currLabel);

      // _objectRecognition(image as CameraImage).then((value) => );
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => EmotionDetectionScreen(emotion: emotion))
      // );
      _imageList.add(list);
      _imageList.refresh();
    }
  }
}