import 'dart:async';
import 'package:christa_app/constants.dart';
import 'package:christa_app/screens/QuestionScreen.dart';
import 'package:christa_app/models/EmotionModel.dart';
import 'package:christa_app/models/user_model.dart';
import 'package:christa_app/screens/cameraScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// import 'package:intl/intl.dart';

class MoodBoardScreen extends StatefulWidget {

  @override
  State<MoodBoardScreen> createState() => _MoodBoardScreenState();
}

class _MoodBoardScreenState extends State<MoodBoardScreen> {

  final emotions = FirebaseFirestore.instance.collection("emotions");


  @override
  void initState() {
    super.initState();
    // emotions.where("email", isEqualTo: "something").get().then(
    //       (querySnapshot) {
    //     print("Successfully completed");
    //     for (var docSnapshot in querySnapshot.docs) {
    //       print('${docSnapshot.id} => ${docSnapshot.data()}');
    //     }
    //   },
    //   onError: (e) => print("Error completing: $e"),
    // );
  }

  String oldEmail = "";

  @override
  Widget build(BuildContext context) {
    String newEmail = context.watch<UserData>().userEmail;
    print(newEmail);
    if (newEmail != oldEmail) {
      if (newEmail.isNotEmpty) {
        if (newEmail.substring(0,1) == "1") {
          newEmail = newEmail.substring(1);
        }
      }
      oldEmail = newEmail;
      setState(() {});
    }
    // Stream<QuerySnapshot<Map<String, dynamic>>> getEmotionsModel () {
    //   return _firestore.collection('user').get().asStream();
    // }
    // final Stream<String> _bids = (() {
    //   late final StreamController<int> controller;
    //   controller = StreamController<int>(
    //     onListen: () async {
    //       await emotions.where("email", isEqualTo: oldEmail.substring(1)).get().asStream();
    //     },
    //   );
    //   return controller.stream;
    // })();

    return Scaffold(
      backgroundColor: fourth,
      appBar: AppBar(
        title: Text(
            'Your Mood Board',
            style: GoogleFonts.dynaPuff(
                color: primary,
                fontSize: 25
            ),
        ),
        leading: BackButton(
            color: Colors.black
        ),
        backgroundColor: secondary,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Icon(
                Icons.camera_alt_outlined,
                color: tertiary,
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => CameraScreen())
                // );
                // print("hi");
                Get.to(CameraScreen());
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Stack(
            //   children: <Widget>[
            //     Align(
            //       alignment: Alignment.bottomRight,
            //       child: FloatingActionButton(
            //         onPressed: () {
            //           Navigator.of(context).push(
            //               MaterialPageRoute(builder: (context) => IconChoiceQuestions())
            //           );
            //         },
            //         child: Icon(Icons.mood_outlined),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.bottomLeft,
            //       child: FloatingActionButton(
            //         onPressed: () {
            //           Navigator.of(context).push(
            //               MaterialPageRoute(builder: (context) => CameraScreen())
            //           );
            //         },
            //         child: Icon(Icons.camera_alt_outlined),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: MediaQuery. of(context).size.height * 0.025,
            ),
            Flexible(
              child: StreamBuilder(
                // stream: emotions.where("email", isEqualTo: newEmail).snapshots(),
                stream: emotions.orderBy("timestamp").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      // print(snapshot.data?.docs[0].data());
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data?.docs[index].data();
                            DateTime date = DateTime.parse(item!["timestamp"].toDate().toString());
                            print(date.hour%12);
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.5,
                                    color: primary,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: primary,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black54,
                                  //     spreadRadius: 1,
                                  //     blurRadius: 3,
                                  //     // changes position of shadow
                                  //   ),
                                  // ],
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            item!["timestamp"].toDate().toString().split(" ")[0].substring(item!["timestamp"].toDate().toString().split(" ")[0].length-5),
                                            style: GoogleFonts.dynaPuff(
                                              fontSize: 28,
                                              color: Colors.white,
                                            ),
                                        ),
                                        date.hour < 12
                                            ?
                                        (date.hour % 12 == 0
                                              ?
                                          Text("12 AM",
                                            style: GoogleFonts.dynaPuff(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                              :
                                          Text(
                                              "${date.hour%12} AM",
                                              style: GoogleFonts.dynaPuff(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                          )
                                        )
                                            :
                                        (date.hour % 12 == 0
                                              ?
                                          Text("12 PM",
                                            style: GoogleFonts.dynaPuff(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                              :
                                          Text(
                                            "${date.hour%12} PM",
                                            style: GoogleFonts.dynaPuff(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 75,
                                      width: 75,
                                      child: Image.asset(
                                          "images/${item!["emotion"].toLowerCase()}.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    // Image.asset(
                                    //     "images/${item!["emotion"].toLowerCase()}.png",
                                    //     scale: 1.5,
                                    // ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Text(
                                      ": ${item!["emotion"]}",
                                      style: GoogleFonts.dynaPuff(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    } else {
                      // This might not be good
                      return Scaffold(
                        backgroundColor: fourth,
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  } else {
                    return Scaffold(
                      backgroundColor: fourth,
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tertiary,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => IconChoiceQuestions())
          );
        },
        child: Icon(Icons.add),
      ),
      // floatingActionButton: SpeedDial(
      //   child: Icon(Icons.add),
      //   activeIcon: Icons.remove,
      //   // animatedIcon: AnimatedIcons.add_event,
      //   overlayOpacity: 0.0,
      //   backgroundColor: null,
      //   activeBackgroundColor: null,
      //   children: [
      //     SpeedDialChild(
      //       child: IconButton(
      //         onPressed: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => IconChoiceQuestions())
      //           );
      //         },
      //         icon: Icon(Icons.mood),
      //       )
      //     ),
      //     SpeedDialChild(
      //       child: IconButton(
      //         onPressed: () {
      //           Navigator.of(context).push(
      //               MaterialPageRoute(builder: (context) => CameraScreen())
      //           );
      //         },
      //         icon: Icon(Icons.camera_alt_outlined),
      //       )
      //     )
      //   ],
      // ),
    );
  }
}