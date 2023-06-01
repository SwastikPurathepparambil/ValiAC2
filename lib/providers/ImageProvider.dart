import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;

class ImageProviderModel extends ChangeNotifier {
  Uint8List image = Uint8List(0);
  String label = "";

  void setLabel(String updatedLabel) {
    label = updatedLabel;
    notifyListeners();
  }

  String getEmail() {
    return label;
  }

  void setImage(Uint8List updatedImage) {
    print("Image has been called to act");
    image = updatedImage;
    notifyListeners();
  }

  Uint8List getImage() {
    return image;
  }

}