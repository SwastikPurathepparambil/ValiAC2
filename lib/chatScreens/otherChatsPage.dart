import 'package:flutter/material.dart';
import 'package:christa_app/constants.dart';

class OtherChats extends StatefulWidget {
  const OtherChats({Key? key}) : super(key: key);

  @override
  _OtherChatsState createState() => _OtherChatsState();
}

class _OtherChatsState extends State<OtherChats> {

  final List<String> _messages = [];
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
    // print(_messages);
    return Scaffold(
      backgroundColor: fourth,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
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
                            message,
                            style: TextStyle(fontSize: 18.0),
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
                                Text("Comment"),
                                SizedBox(
                                  width: 7,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("hi");
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                )
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
    );
  }
}

