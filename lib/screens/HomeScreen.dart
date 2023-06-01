import 'package:christa_app/cameraViewer.dart';
import 'package:christa_app/chatScreens/otherChatsPage.dart';
import 'package:christa_app/screens/CommunityScreen.dart';
import 'package:christa_app/screens/MoodBoardScreen.dart';
import 'package:christa_app/constants.dart';
import 'package:christa_app/screens/cameraScreen.dart';
import 'SpeechScreen.dart';
import 'package:christa_app/main.dart';
import 'package:christa_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String oldEmail = "";

  @override
  Widget build(BuildContext context) {

    String newEmail = context.watch<UserData>().userEmail;
    if (newEmail != oldEmail) {
      oldEmail = newEmail;
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        title: Text(
            "ValiAC",
          style: GoogleFonts.dynaPuff(
            color: primary,
            fontSize: 28
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [tertiary, fourth],
              // ),
              color: fourth
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0.02 * MediaQuery.of(context).size.height,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10),
                    child: Text(
                      "YOUR LATE-NIGHT FRIEND",
                      style: GoogleFonts.dynaPuff(
                          fontSize: 20,
                          color: secondary
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.02 * MediaQuery.of(context).size.height,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 0.025 * MediaQuery.of(context).size.width,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.1 * MediaQuery.of(context).size.width),
                        child: Container(
                          child: Image.asset("images/chatIcon.png"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.1 * MediaQuery.of(context).size.width,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 0.35 * MediaQuery.of(context).size.width,
                            child: Text(
                              "How are you feeling?",
                              style: GoogleFonts.dynaPuff(
                                color: secondary,
                                fontSize: 0.026 * MediaQuery.of(context).size.height,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.025 * MediaQuery.of(context).size.height,
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
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => ChatScreen())
                                );
                              },
                              child: Text(
                                "Let's talk",
                                style: GoogleFonts.lato(fontSize: 20, color: secondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.035 * MediaQuery.of(context).size.height,
                ),
                Divider(

                  height: 10,
                  thickness: 0.75,
                  color: tertiary,
                ),
                SizedBox(
                  height: 0.02 * MediaQuery.of(context).size.height,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10),
                    child: Text(
                      "MY REFLECTION TOOL",
                      style: GoogleFonts.dynaPuff(
                          fontSize: 20,
                          color: secondary
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 0.1 * MediaQuery.of(context).size.width,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 0.4 * MediaQuery.of(context).size.width,
                          child: Text(
                            "Reflect on your thoughts and emotions",
                            style: GoogleFonts.dynaPuff(
                              color: secondary,
                              fontSize: 0.027 * MediaQuery.of(context).size.height,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.025 * MediaQuery.of(context).size.height,
                        ),
                        Container(
                          width: 0.25 * MediaQuery.of(context).size.width,
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
                            onPressed: () {
                              Navigator.pushNamed(context, '/emo');
                              // Navigator.of(context).push(
                              //     MaterialPageRoute(builder: (context) => MoodBoardScreen())
                              // );
                            },
                            child: Text(
                              "Reflect",
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: secondary
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    Container(
                      child: Flexible(
                        child: Image.asset("images/mirrorIcon.png"),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 0.025 * MediaQuery.of(context).size.height,
                ),
                Divider(
                  height: 10,
                  thickness: 0.75,
                  color: tertiary,
                ),
                SizedBox(
                  height: 0.02 * MediaQuery.of(context).size.height,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10),
                    child: Text(
                      "OUR COMMUNITY",
                      style: GoogleFonts.dynaPuff(
                          fontSize: 20,
                          color: secondary
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.02 * MediaQuery.of(context).size.height,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 0.025 * MediaQuery.of(context).size.width,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.1 * MediaQuery.of(context).size.width),
                        child: Image.asset('images/commsIcon.png'),
                      ),
                    ),
                    SizedBox(
                      width: 0.1 * MediaQuery.of(context).size.width,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 0.4 * MediaQuery.of(context).size.width,
                            child: Text(
                              "Speak with others in the same boat",
                              style: GoogleFonts.dynaPuff(
                                color: secondary,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.025 * MediaQuery.of(context).size.height,
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
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => CommunityScreen())
                                );
                              },
                              child: Text(
                                "Join",
                                style: GoogleFonts.lato(fontSize: 20, color: secondary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.035 * MediaQuery.of(context).size.height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
