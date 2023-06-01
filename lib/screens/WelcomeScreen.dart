import 'package:christa_app/screens/HomeScreen.dart';
import 'package:christa_app/models/user_model.dart';
import 'package:christa_app/providers/userLocalStorage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Updates
//Frontend Complete
//Need to build and add backend


class WelcomeScreen extends StatefulWidget {
  final String email;

  WelcomeScreen(this.email);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final users = FirebaseFirestore.instance.collection("users");
  final TextEditingController nameController = TextEditingController();

  Future<void> addUser(String email, String username) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'email': email, // John Doe
      'username': username, // Stokes and Sons
    }).then((value) {
      UserDataStorage().writeCounter("1${widget.email}");
      Provider.of<UserData>(context, listen: false).updateEmail(widget.email);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomeScreen(name: nameController.text))
      );
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFF9CEC74)],
          ),
          color: Colors.white60
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text.rich(
                        TextSpan(
                            text: "Hey! I'm ",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF555555)
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Christa',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6AD557)
                                ),
                              )
                            ]
                        )
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        Text(
                            "Our conversations are private",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF636363),
                            ),
                        ),
                        Text(
                            "& anonymous. Just choose a ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF636363),
                            ),
                        ),
                        Text(
                            "nickname and we're good to go.",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF636363),
                            ),
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            cursorColor: Colors.green,
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 22.5),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter your name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusColor: Colors.greenAccent,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.greenAccent,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                addUser(widget.email, nameController.text);
                              },
                              color: Color(0xFF84D958),
                              textColor: Colors.white,
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 24,
                              ),
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                            ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
