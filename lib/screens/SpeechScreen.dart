import 'dart:developer';

import 'package:christa_app/constants.dart';
import 'package:christa_app/models/chat_model.dart';
import 'package:christa_app/providers/chats_provider.dart';
import 'package:christa_app/services/api_service.dart';
import 'package:christa_app/services/services.dart';
import 'package:christa_app/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../../providers/models_provider.dart';
import '../../widgets/text_widget.dart';
import '../isQuestion.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late SpeechToText _speech;
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  bool _isListening = false;
  String _text = "";

  TextToSpeech tts = TextToSpeech();
  String text = '';
  double volume = 1; // Range: 0-1
  double rate = 1.05; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  String? voice;
  final String defaultLanguage = 'en-US';

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    _speech = SpeechToText();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    initLanguages();
    // });
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    // languageCodes = await tts.getLanguages();

    /// populate displayed language (i.e. English)
    // final List<String>? displayLanguages = await tts.getDisplayLanguages();
    // if (displayLanguages == null) {
    //   return;
    // }

    // languages.clear();
    // for (final dynamic lang in displayLanguages) {
    //   if (!languages.contains(lang)) {
    //     languages.add(lang as String);
    //   }
    // }

    // final String? defaultLangCode = await tts.getDefaultLanguage();
    // if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
    //   languageCode = defaultLangCode;
    // } else {
    //   languageCode = defaultLanguage;
    // }
    // language = await tts.getDisplayLanguageByCode("en-US");

    /// get voice
    voice = "en-US";

    if (mounted) {
      setState(() {});
    }
  }

  // Future<String?> getVoiceByLang(String lang) async {
  //   final List<String>? voices = await tts.getVoiceByLang("en-US");
  //   if (voices != null && voices.isNotEmpty) {
  //     return voices.first;
  //   }
  //   return null;
  // }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: fourth,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        backgroundColor: secondary,
        title: Text(
            "Let's Talk",
            style: GoogleFonts.dynaPuff(
                color: primary,
                fontSize: 28
            ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatProvider.getChatList.length, //chatList.length,
                  itemBuilder: (context, index) {
                    // scrollListToEND();
                    return ChatWidget(
                      msg: chatProvider
                          .getChatList[index].msg, // chatList[index].msg,
                      chatIndex: chatProvider.getChatList[index]
                          .chatIndex, //chatList[index].chatIndex,
                    );
                  }),
            ),
            if (_isTyping) ...[
              SpinKitThreeBounce(
                color: secondary,
                size: 18,
              ),
            ],
            SizedBox(
              height: MediaQuery.of(context).size.height*0.0075,
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
                        maxLines: null,
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.black),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider);
                          textEditingController.text = "";
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "Type or use the mic",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    AvatarGlow(
                      animate: _isListening,
                      glowColor: Colors.redAccent,
                      endRadius: 25.0,
                      duration: const Duration(milliseconds: 2000),
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      repeat: true,
                      child: IconButton(
                        onPressed: _listen,
                        icon: Icon(
                          Icons.mic,
                          color: _isListening ? Colors.red : Colors.black,
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: _listen,
                    //   icon: Icon(
                    //     Icons.mic,
                    //     color: _isListening ? Colors.red : Colors.black,
                    //   ),
                    // ),
                    IconButton(
                        onPressed: () async {
                          await sendMessageFCT(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider
                          );
                          scrollListToEND();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.black,
                        ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.02,
            )
          ],
        ),
      ),
    );
  }



  void scrollListToEND() {
    _listScrollController.jumpTo(_listScrollController.position.maxScrollExtent);
  }

  void _listen() async {
    try {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: ${val.errorMsg}'),
        );
        if (available) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (val) => setState(() {
              _text = val.recognizedWords;
              textEditingController.text = _text;
            }),
          );
        }
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
        required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;

      setState(() {
        _isTyping = true;
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        scrollListToEND();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg, chosenModelId: modelsProvider.getCurrentModel
      ).then((value) {
        print(value);
        tts.setVolume(volume);
        tts.setRate(rate);
        tts.setLanguage("en-AU");
        tts.setPitch(pitch);
        // TODO: EDIT THIS TEXT ON RECORDING
        tts.speak("Listen to them without judgment, "
            "validate their experiences and emotions, "
            "offer support and resources if needed, "
            "maintain confidentiality unless there "
            "are safety concerns, and respect their boundaries."
        );
      });
      // chatList.addAll(await ApiService.sendMessage(
      //   message: textEditingController.text,
      //   modelId: modelsProvider.getCurrentModel,
      // ));
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
