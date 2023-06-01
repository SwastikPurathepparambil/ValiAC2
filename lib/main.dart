import 'package:camera/camera.dart';
import 'package:christa_app/NavigatingWidget.dart';
import 'package:christa_app/globalBindings.dart';
import 'package:christa_app/providers/ImageProvider.dart';
import 'package:christa_app/screens/MoodBoardScreen.dart';
import 'package:christa_app/screens/SignupScreen.dart';
import 'package:christa_app/screens/WelcomeScreen.dart';
import 'package:christa_app/models/user_model.dart';
import 'package:christa_app/providers/userLocalStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'screens/SpeechScreen.dart';
import 'package:christa_app/providers/models_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'constants.dart';
import 'providers/chats_provider.dart';
import 'screens/SpeechScreen.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:text_to_speech/text_to_speech.dart';

// late List<CameraDescription> _cameras;
// TODO: Update unquant file -- teachable machine
// TODO: Create a slpash screen and add an app screen icon

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalBindings().dependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // _cameras = await availableCameras();
  runApp(MyApp());
}

// Two main features:
// 1. Being able to just sit down and talk
// 2. Mood Tracking
// 3. Conversation T


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(_cameras.isEmpty);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
            create: (_) => UserData(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImageProviderModel(),
        )
      ],
      child: GetMaterialApp(
        title: 'Flutter ChatBOT',
        initialBinding: GlobalBindings(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              color: cardColor,
            )),
        //Switched to Welcome Screen
        // home: NavigatorWidget(),
        initialRoute: '/',
        routes: {
          '/': (context) => NavigatorWidget(),
          '/emo': (context) => MoodBoardScreen(),
        },
      ),
    );
  }
}



// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final String defaultLanguage = 'en-US';
//
//   TextToSpeech tts = TextToSpeech();
//
//   String text = '';
//   double volume = 1; // Range: 0-1
//   double rate = 1.0; // Range: 0-2
//   double pitch = 1.0; // Range: 0-2
//
//   String? language;
//   String? languageCode;
//   List<String> languages = <String>[];
//   List<String> languageCodes = <String>[];
//   String? voice;
//
//   TextEditingController textEditingController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     textEditingController.text = text;
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       initLanguages();
//     });
//   }
//
//   Future<void> initLanguages() async {
//     /// populate lang code (i.e. en-US)
//     languageCodes = await tts.getLanguages();
//
//     /// populate displayed language (i.e. English)
//     final List<String>? displayLanguages = await tts.getDisplayLanguages();
//     if (displayLanguages == null) {
//       return;
//     }
//
//     languages.clear();
//     for (final dynamic lang in displayLanguages) {
//       if (!languages.contains(lang)) {
//         languages.add(lang as String);
//       }
//     }
//
//     final String? defaultLangCode = await tts.getDefaultLanguage();
//     if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
//       languageCode = defaultLangCode;
//     } else {
//       languageCode = defaultLanguage;
//     }
//     language = await tts.getDisplayLanguageByCode(languageCode!);
//
//     /// get voice
//     voice = await getVoiceByLang(languageCode!);
//
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   Future<String?> getVoiceByLang(String lang) async {
//     final List<String>? voices = await tts.getVoiceByLang(languageCode!);
//     if (voices != null && voices.isNotEmpty) {
//       return voices.first;
//     }
//     return null;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     print(languages);
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Text-to-Speech Example'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     controller: textEditingController,
//                     maxLines: 5,
//                     decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Enter some text here...'),
//                     onChanged: (String newText) {
//                       setState(() {
//                         text = newText;
//                       });
//                     },
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Volume'),
//                       Expanded(
//                         child: Slider(
//                           value: volume,
//                           min: 0,
//                           max: 1,
//                           label: volume.round().toString(),
//                           onChanged: (double value) {
//                             initLanguages();
//                             setState(() {
//                               volume = value;
//                             });
//                           },
//                         ),
//                       ),
//                       Text('(${volume.toStringAsFixed(2)})'),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Rate'),
//                       Expanded(
//                         child: Slider(
//                           value: rate,
//                           min: 0,
//                           max: 2,
//                           label: rate.round().toString(),
//                           onChanged: (double value) {
//                             setState(() {
//                               rate = value;
//                             });
//                           },
//                         ),
//                       ),
//                       Text('(${rate.toStringAsFixed(2)})'),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Pitch'),
//                       Expanded(
//                         child: Slider(
//                           value: pitch,
//                           min: 0,
//                           max: 2,
//                           label: pitch.round().toString(),
//                           onChanged: (double value) {
//                             setState(() {
//                               pitch = value;
//                             });
//                           },
//                         ),
//                       ),
//                       Text('(${pitch.toStringAsFixed(2)})'),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Language'),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       DropdownButton<String>(
//                         value: language,
//                         icon: const Icon(Icons.arrow_downward),
//                         iconSize: 24,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple),
//                         underline: Container(
//                           height: 2,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? newValue) async {
//                           languageCode =
//                           await tts.getLanguageCodeByName(newValue!);
//                           voice = await getVoiceByLang(languageCode!);
//                           setState(() {
//                             language = newValue;
//                           });
//                         },
//                         items: languages
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: <Widget>[
//                       const Text('Voice'),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Text(voice ?? '-'),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.only(right: 10),
//                           child: ElevatedButton(
//                             child: const Text('Stop'),
//                             onPressed: () {
//                               tts.stop();
//                             },
//                           ),
//                         ),
//                       ),
//                       if (supportPause)
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.only(right: 10),
//                             child: ElevatedButton(
//                               child: const Text('Pause'),
//                               onPressed: () {
//                                 tts.pause();
//                               },
//                             ),
//                           ),
//                         ),
//                       if (supportResume)
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.only(right: 10),
//                             child: ElevatedButton(
//                               child: const Text('Resume'),
//                               onPressed: () {
//                                 tts.resume();
//                               },
//                             ),
//                           ),
//                         ),
//                       Expanded(
//                           child: Container(
//                             child: ElevatedButton(
//                               child: const Text('Speak'),
//                               onPressed: () {
//                                 speak();
//                               },
//                             ),
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   bool get supportPause => defaultTargetPlatform != TargetPlatform.android;
//
//   bool get supportResume => defaultTargetPlatform != TargetPlatform.android;
//
//   void speak() {
//     tts.setVolume(volume);
//     tts.setRate(rate);
//     if (languageCode != null) {
//       tts.setLanguage(languageCode!);
//     }
//     tts.setPitch(pitch);
//     tts.speak(text);
//   }
// }