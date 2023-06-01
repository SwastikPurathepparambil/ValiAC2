import 'package:christa_app/chatScreens/comingOutPage.dart';
import 'package:christa_app/chatScreens/discriminationPage.dart';
import 'package:christa_app/chatScreens/legalIssuesPage.dart';
import 'package:christa_app/chatScreens/mentalHealthPage.dart';
import 'package:christa_app/chatScreens/otherChatsPage.dart';
import 'package:christa_app/chatScreens/situationsPage.dart';
import 'package:christa_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // final List<String> _messages = [];
  // late FocusNode focusNode;
  // final TextEditingController _textController = TextEditingController();
  //
  // @override
  // void initState() {
  //   focusNode = FocusNode();
  //   super.initState();
  // }
  //
  // void _handleSubmitted(String text) {
  //   _textController.clear();
  //   setState(() {
  //     _messages.insert(0, text);
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   focusNode.dispose();
  //   super.dispose();
  // }

  int pageIndex = 0;
  final pages = [MentalHealthChat(), ComingOutChat(), LegalIssuesChat(), DiscriminationPage(), SituationsChat(), OtherChats()];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: fourth,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        backgroundColor: secondary,
        title: Text(
          "Community",
          style: GoogleFonts.dynaPuff(
              color: primary,
              fontSize: 28
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: Column(
              children: [
                Container(
                  color: fourth,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex = 0;
                          });
                        },
                        //NEED BOX SHADOW HERE, FIX UP THE COLORS AND FONTS AND WE'RE DONE
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.025,
                          // borderRadius: BorderRadius.circular(20),
                          // color: fourth,
                          // elevation: 30,
                          // shadowColor: fourth,
                          decoration: BoxDecoration(
                            color: pageIndex != 0 ? fourth : secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: pageIndex != 0 ? [
                              BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(2, 2), // changes position of shadow
                              )
                            ]: null,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                                child: Text(
                                  'Mental Health',
                                  style: GoogleFonts.dynaPuff(
                                      fontSize: 22,
                                      color: primary
                                  ),
                                ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: pageIndex != 1 ? fourth : secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: pageIndex != 1 ? [
                              BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(2, 2), // changes position of shadow
                              )
                            ]: null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                'Coming Out',
                                style: GoogleFonts.dynaPuff(
                                    fontSize: 22,
                                    color: primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex = 2;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: pageIndex != 2 ? fourth : secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: pageIndex != 2 ? [
                              BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(2, 2), // changes position of shadow
                              )
                            ]: null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                'Rights/Legal Issues',
                                style: GoogleFonts.dynaPuff(
                                    fontSize: 22,
                                    color: primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex = 3;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: pageIndex != 3 ? fourth : secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: pageIndex != 3 ? [
                              BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(2, 2), // changes position of shadow
                              )
                            ]: null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                'Discrimination',
                                style: GoogleFonts.dynaPuff(
                                    fontSize: 22,
                                    color: primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex = 4;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: pageIndex != 4 ? fourth : secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: pageIndex != 4 ? [
                              BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(2, 2), // changes position of shadow
                              )
                            ]: null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                'Transitioning',
                                style: GoogleFonts.dynaPuff(
                                    fontSize: 22,
                                    color: primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pageIndex = 5;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: pageIndex != 5 ? fourth : secondary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: pageIndex != 5 ? [
                              BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(2, 2), // changes position of shadow
                              )
                            ]: null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: Text(
                                'Other',
                                style: GoogleFonts.dynaPuff(
                                    fontSize: 22,
                                    color: primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                color: tertiary,
                child: IndexedStack(
                  index: pageIndex,
                  children: pages,
                ),
              ),
          ),




          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _messages.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       final message = _messages[index];
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 8.0,
          //           vertical: 4.0,
          //         ),
          //         child: Card(
          //           elevation: 4.0,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   message,
          //                   style: GoogleFonts.dynaPuff()(fontSize: 18.0),
          //                 ),
          //                 SizedBox(
          //                   height: 5,
          //                 ),
          //                 GestureDetector(
          //                   onTap: () {
          //                     print("hi");
          //                   },
          //                   child: Row(
          //                     children: [
          //                       Icon(
          //                           Icons.chat,
          //                           color: Colors.black,
          //                         size: 20,
          //                       ),
          //                       SizedBox(
          //                         width: 3,
          //                       ),
          //                       Text("Comment")
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 20),
          //   decoration: BoxDecoration(
          //     color: cardColor,
          //     borderRadius: BorderRadius.circular(30),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         SizedBox(
          //           width: 10,
          //         ),
          //         Expanded(
          //           child: TextField(
          //             focusNode: focusNode,
          //             style: const GoogleFonts.dynaPuff()(color: Colors.black),
          //             controller: _textController,
          //             onSubmitted: (value)  {},
          //             decoration: const InputDecoration.collapsed(
          //                 hintText: "Add to the community",
          //                 hintStyle: GoogleFonts.dynaPuff()(color: Colors.grey)),
          //           ),
          //         ),
          //         IconButton(
          //             onPressed: () {
          //               _handleSubmitted(_textController.text);
          //             },
          //             icon: const Icon(
          //               Icons.send,
          //               color: Colors.black,
          //             ))
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.05,
          // ),

        ],
      ),
    );
  }
}

class MessageComments extends StatefulWidget {
  const MessageComments({Key? key}) : super(key: key);

  @override
  _MessageCommentsState createState() => _MessageCommentsState();
}

class _MessageCommentsState extends State<MessageComments> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " ",
                style: GoogleFonts.dynaPuff(fontSize: 18.0),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  print("hi");
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.chat,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("Comment")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
