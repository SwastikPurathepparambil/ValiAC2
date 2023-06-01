import 'package:christa_app/providers/ImageProvider.dart';
import 'package:christa_app/providers/userLocalStorage.dart';
import 'package:christa_app/screens/MoodBoardScreen.dart';
import 'package:christa_app/screens/emotionResultScreen.dart';
import 'package:christa_app/services/scanController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:christa_app/services/scanController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

import '../constants.dart';


class EmotionDetectionScreen extends StatefulWidget {
  const EmotionDetectionScreen({Key? key}) : super(key: key);

  @override
  _EmotionDetectionScreenState createState() => _EmotionDetectionScreenState();
}

class _EmotionDetectionScreenState extends State<EmotionDetectionScreen> {

  Uint8List oldImage = Uint8List(1);
  String oldLabel = "";
  final emotions = FirebaseFirestore.instance.collection("emotions");

  Future<void> addEmotion(String email, String emotion) {
    // Call the user's CollectionReference to add a new user
    print(DateTime.now());
    return emotions
        .add({
      'email': email,
      'emotion': emotion,
      'timestamp': DateTime.now(),
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    Uint8List newImage = context.watch<ImageProviderModel>().image;
    if (newImage != oldImage) {
      print("OldImage: $oldImage");

      oldImage = newImage;
      print("Did something change?: $newImage");
      setState(() {});
    }
    String newLabel = context.watch<ImageProviderModel>().label;
    if (newLabel != oldLabel) {
      oldLabel = newLabel;
      print("Did something change?: $newLabel");
      setState(() {});
    }

    // print("Image List: ${controller.imageList.length}");
    return Scaffold(
      backgroundColor: fourth,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Results",
                style: GoogleFonts.dynaPuff(
                    color: primary,
                    fontSize: 30
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              newImage.length > 1 ? SizedBox(
                height: 300,
                width: 225,
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
                    borderRadius: BorderRadius.circular(10),
                    child: RepaintBoundary(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(newImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ) : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Text(
                  "You are: ${newLabel}",
                  style: GoogleFonts.dynaPuff(
                    fontSize: 20,
                    color: primary
                  ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                  color: primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    UserDataStorage().readCounter().then((value) {
                      if (value[0] == "1" || value[0] == "0") {
                        if (value[1] == "0") {
                          addEmotion(value.substring(2), newLabel);
                        }
                        addEmotion(value.substring(1), newLabel);
                      } else {
                        addEmotion(value, newLabel);
                      }
                    });
                    //Have something show up with the face on the screen
                    // Navigator.pop(context);
                    // Navigator.pop(context);
                    Navigator.popUntil(context, ModalRoute.withName('/emo'));
                  },
                  child: Text(
                      "Continue",
                      style: GoogleFonts.dynaPuff(
                        fontSize: 24,
                        color: secondary
                      ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}