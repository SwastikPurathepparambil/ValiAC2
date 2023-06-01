import 'package:christa_app/ErrorHandling.dart';
import 'package:christa_app/screens/HomeScreen.dart';
import 'package:christa_app/screens/LoginScreen.dart';
import 'package:christa_app/screens/SignupScreen.dart';
import 'package:christa_app/screens/WelcomeScreen.dart';
import 'package:christa_app/models/user_model.dart';
import 'package:christa_app/providers/userLocalStorage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigatorWidget extends StatefulWidget {
  const NavigatorWidget({Key? key}) : super(key: key);

  @override
  _NavigatorWidgetState createState() => _NavigatorWidgetState();
}

class _NavigatorWidgetState extends State<NavigatorWidget> {

  String userEmail = '';

  @override
  void initState() {
    super.initState();

    UserDataStorage().readCounter().then((value) {
      userEmail = value;
      Provider.of<UserData>(context, listen: false).updateEmail(userEmail);
    }, onError: (e) => print(e));
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: UserDataStorage().readCounter(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print("snapshot.error");
              return ErrorHandling(errorHandlingText: (snapshot.error)!.toString(),);
            } else {
              if ((snapshot.data)!.isNotEmpty) {
                if ((snapshot.data)![0] == "0") {
                  return WelcomeScreen(snapshot.data!);
                } else if ((snapshot.data)![0] == "1") {
                  return HomeScreen(name: snapshot.data!);
                } else {
                  return LoginScreen();
                }
              } else {
                return SignupScreen();
              }

            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );
  }
}
