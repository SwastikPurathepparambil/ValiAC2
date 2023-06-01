import 'package:christa_app/models/user_model.dart';
import 'package:christa_app/providers/userLocalStorage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:christa_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ComingOutChat extends StatefulWidget {
  const ComingOutChat({Key? key}) : super(key: key);

  @override
  _ComingOutChatState createState() => _ComingOutChatState();
}

class _ComingOutChatState extends State<ComingOutChat> {

  final page = FirebaseFirestore.instance.collection("comingoutconversation");

  final List<String> _messages = [
    "Hey guys, I wanted to share my coming out story with you all as this felt like a pretty safe space to do so. When I was 16, I came out to my parents as gay. It was really scary, but I knew I had to do it.",
    "That's really brave of you. How did your parents react?",
    "At first, they were really upset and didn't understand. But over time, they came to accept me for who I am.",
    "That's really great to hear. Coming out can be such a difficult process, especially when you're not sure how people will react.",
    "I can definitely relate to that. When I came out to my friends, I was so scared they would reject me. But they were amazing. They accepted me for who I am, and it was such a huge weight off my shoulders.",
    "That's so awesome. I wish everyone could have that kind of support and acceptance.",
  ];
  List<Color> colorList = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.deepPurple];
  late FocusNode focusNode;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
  }

  Future<void> addToChat(String email, String text, String name) {
    // Call the user's CollectionReference to add a new user
    print(DateTime.now());
    return page.add({
      'email': email,
      'name': name,
      'text': text,
      'timestamp': DateTime.now(),
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.add(text);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fourth,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: page.orderBy("timestamp").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {

                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    print("SNAPSHOOOOOOOOT: ${snapshot.data?.docs.length}");
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(index);
                        final message = snapshot.data?.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Card(
                            color: colorList[index % (colorList.length-1)],
                            elevation: 4.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message!["text"],
                                    style: GoogleFonts.dynaPuff(
                                      fontSize: 20.0,
                                    ),
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
                                          width: 4,
                                        ),
                                        LikedCommentIcon(index),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      style: const TextStyle(color: Colors.black),
                      controller: _textController,
                      onSubmitted: (value)  {},
                      decoration: const InputDecoration.collapsed(
                          hintText: "Add to the community",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        UserDataStorage().readCounter().then((value) {
                          if (value[0] == "1" || value[0] == "0") {
                            if (value[1] == "0") {
                              addToChat(value.substring(2), _textController.text, UserData().userName);
                            }
                            addToChat(value.substring(1), _textController.text, UserData().userName);
                          } else {
                            addToChat(value, _textController.text, UserData().userName);
                          }
                        });
                        // _handleSubmitted(_textController.text);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
        ],
      ),
    );
  }
}

class LikedCommentIcon extends StatefulWidget {
  final int index;
  const LikedCommentIcon(this.index);

  @override
  _LikedCommentIconState createState() => _LikedCommentIconState();
}

class _LikedCommentIconState extends State<LikedCommentIcon> {
  List<Color> colorList = [Colors.green, Colors.blue, Colors.deepPurple, Colors.red, Colors.orange, Colors.yellow];
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          liked = !liked;
        });
      },
      child: Row(
        children: [
          Icon(
            liked ? Icons.favorite : Icons.favorite_border,
            color: liked ? colorList[widget.index % (colorList.length-1)] : Colors.black,
            size: 20,
          ),
        ],
      ),
    );
  }
}


