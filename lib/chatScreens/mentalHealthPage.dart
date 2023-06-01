import 'dart:math';

import 'package:flutter/material.dart';
import 'package:christa_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class MentalHealthChat extends StatefulWidget {
  const MentalHealthChat({Key? key}) : super(key: key);

  @override
  _MentalHealthChatState createState() => _MentalHealthChatState();
}

class _MentalHealthChatState extends State<MentalHealthChat> {

  final List<String> _messages = [
    "Hey guys, I wanted to talk to you all about something that's been on my mind lately.",
    "Sure, what's up?",
    "I've been struggling a lot with my mental health lately. It's been really hard for me to accept and love myself for who I am as a gay man.",
    "I'm so sorry to hear that. Is there anything we can do to support you?",
    "Honestly, just being here and listening to me means a lot. Sometimes it feels like nobody understands what I'm going through.",
    "I can relate to that. As a trans woman, it's been a real struggle for me to feel like I belong anywhere.",
    "I feel you. It can be really tough to find acceptance and support, especially when you don't fit into society's narrow boxes.",
    "Absolutely. But let's remember that we're not alone. We have each other, and there are plenty of people out there who accept and love us for who we are.",
    "Thank you all for being here and supporting me. It means a lot to know that I have friends who understand what I'm going through.",
    "Of course, we're here for you. And remember, it's okay to not be okay. Mental health struggles are nothing to be ashamed of.",
  ];
  List<Color> colorList = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.deepPurple];
  late FocusNode focusNode;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    focusNode = FocusNode();
    super.initState();
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                print(index);
                final message = _messages[index];
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
                            message,
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
                        _handleSubmitted(_textController.text);
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


