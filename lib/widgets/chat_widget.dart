import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:christa_app/TextAnimation.dart';
import 'package:christa_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    final bool alreadySent;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: chatIndex == 0 ? MediaQuery. of(context).size.width * 0.3 : MediaQuery. of(context).size.width * 0.025,
              top: 10,
              right: chatIndex == 0 ? MediaQuery. of(context).size.width * 0.025 : MediaQuery. of(context).size.width * 0.3
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: chatIndex == 0 ? Radius.circular(10) : Radius.circular(0),
                topRight: chatIndex == 0 ? Radius.circular(0) : Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: chatIndex == 0 ? primary : secondary,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: chatIndex == 0
                        ? TextWidget(
                            label: msg,
                            color: Colors.white,
                          )
                        : DefaultTextStyle(
                            style: GoogleFonts.dynaPuff(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16
                            ),
                            child: TextAnimationWidget(
                              text: msg,
                              animationDuration: Duration(
                                  seconds: ((msg.length)/17.5 + 0.25).toInt(),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
