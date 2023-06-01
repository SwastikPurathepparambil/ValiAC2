import 'package:flutter/material.dart';
import 'package:christa_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class LegalIssuesChat extends StatefulWidget {
  const LegalIssuesChat({Key? key}) : super(key: key);

  @override
  _LegalIssuesChatState createState() => _LegalIssuesChatState();
}

class _LegalIssuesChatState extends State<LegalIssuesChat> {

  final List<String> _messages = [
    "I got fired from my job last week, and I think it's because of my sexual orientation. I'm considering taking legal action, but I'm not sure where to start.",
    "That's discrimination, plain and simple. You should definitely talk to a lawyer and see what your options are.",
    "Absolutely. And don't worry about the cost, there are plenty of LGBTQ organizations that offer legal assistance to people in your situation.",
    "Yeah, and even if you don't want to pursue legal action, it might be helpful to talk to a lawyer and find out what your rights are.",
    "I'm so sorry this is happening to you. It's not fair that you're being discriminated against just because of who you are.",
    "Definitely talk to a lawyer. It's important to hold your employer accountable and make sure they don't get away with this kind of discrimination.",
    "Thank you all for your support and advice. It means a lot to me. I'll definitely look into talking to a lawyer and see what my options are.",
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