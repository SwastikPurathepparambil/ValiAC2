import 'package:christa_app/constants.dart';
import 'package:christa_app/models/user_model.dart';
import 'package:christa_app/providers/userLocalStorage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IconChoiceQuestions extends StatefulWidget {
  const IconChoiceQuestions({Key? key}) : super(key: key);

  @override
  _IconChoiceQuestionsState createState() => _IconChoiceQuestionsState();
}

class _IconChoiceQuestionsState extends State<IconChoiceQuestions> {

  String currentQuestion = "How are you feeling right now?";
  final emotions = FirebaseFirestore.instance.collection("emotions");
  List<String> selectedCategory = <String>[];

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

  _buildButton(String reason, String img) {
    return GestureDetector(
      onTap: () {
        if (selectedCategory.isNotEmpty) {
          if (selectedCategory.contains(reason)) {
            selectedCategory.remove(reason);
          } else {
            selectedCategory.removeAt(0);
            selectedCategory.add(reason);
          }
        } else {
          selectedCategory.add(reason);
        }
        setState(() {});
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 90,
            width: 95,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: selectedCategory.contains(reason)
                      ? const Color(0xff74a9bd)
                      : const Color(0xff74a9bd),
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: const Offset(
                    0,
                    4,
                  ),
                )
              ],
              border: Border.all(
                  color: selectedCategory.contains(reason)
                      ? tertiary
                      : primary,
                  width: 8),
              borderRadius: const BorderRadius.all(
                Radius.circular(6),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 89,
              width: 87,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      img,
                      scale: 2.5,
                    ),
                    Text(
                      reason,
                      style: GoogleFonts.dynaPuff(
                        color: const Color.fromRGBO(255, 255, 255, 1.0),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: selectedCategory.contains(reason)
                    ? tertiary
                    : primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: fourth,
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height*0.1),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width*0.05),
                        child: Text(
                          "How are you feeling right now?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dynaPuff(
                              fontSize: height*0.045,
                              color: Colors.white
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.05),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton("Content", "images/content.png"),
                            SizedBox(width: width * 0.025),
                            _buildButton("Goofy", "images/goofy.png"),
                            SizedBox(width: width * 0.025),
                            _buildButton("Excited", "images/excited.png"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton("Sad", "images/sad.png"),
                            SizedBox(width: width*0.025),
                            _buildButton("Anxious", "images/anxious.png"),
                            SizedBox(width: width*0.025),
                            _buildButton("Annoyed", "images/annoyed.png"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton("Disappointed", "images/disappointed.png"),
                            SizedBox(width: width*0.025),
                            _buildButton("Frustrated", "images/frustrated.png"),
                            SizedBox(width: width*0.025),
                            _buildButton("Angry", "images/angry.png"),
                          ],
                        ),
                      ),
                      SizedBox(height: height*0.025),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    UserDataStorage().readCounter().then((value) {
                      if (value[0] == "1" || value[0] == "0") {
                        if (value[1] == "0") {
                          addEmotion(value.substring(2), selectedCategory.first);
                        }
                        addEmotion(value.substring(1), selectedCategory.first);
                      } else {
                        addEmotion(value, selectedCategory.first);
                      }
                    });
                    // Provider.of<CheckIn>(context, listen: false).addCheckIn();
                    // Amplify.Auth.fetchUserAttributes().then((value) {
                    //   var name = value[value.indexWhere((element) => element.userAttributeKey == CognitoUserAttributeKey.name)].value;
                    //   var time = DateTime.now();
                    //   CheckInData checkIn = CheckInData(name: name, question: currentQuestion, response: selectedCategory[0], crdAt: time);
                    //   MongoDatabase.insertCheckIn(checkIn);
                    // });
                    //
                    // Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: Text(
                          "SUBMIT",
                          style: GoogleFonts.dynaPuff(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                )
              ],
            ),
          )
      ),
    );
  }
}