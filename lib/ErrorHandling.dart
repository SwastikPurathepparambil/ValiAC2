import 'package:flutter/material.dart';

class ErrorHandling extends StatefulWidget {
  final String errorHandlingText;
  const ErrorHandling({Key? key, this.errorHandlingText=" "}) : super(key: key);

  @override
  _ErrorHandlingState createState() => _ErrorHandlingState();
}

class _ErrorHandlingState extends State<ErrorHandling> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ErrorHandlingWidget(errorText: widget.errorHandlingText,),
    );
  }
}

class ErrorHandlingWidget extends StatefulWidget {
  final String errorText;

  const ErrorHandlingWidget({Key? key, this.errorText = " "}) : super(key: key);

  @override
  _ErrorHandlingWidgetState createState() => _ErrorHandlingWidgetState();
}

class _ErrorHandlingWidgetState extends State<ErrorHandlingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(9, 12, 48, 1.0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height) - (MediaQuery.of(context).size.height * 0.4),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.15
              ),
              child: Image.asset(
                "assets/error_astronaut.png",
                fit: BoxFit.fill,
              ),

            ),
            Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height*0.1),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.075
              ),
              child: Text(
                "OOPS. It looks like an error occurred.",
                style: TextStyle(
                  color: Color.fromRGBO(255, 178, 0, 1.0),
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height*0.18),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.075
              ),
              child: Text(
                widget.errorText,
                style: TextStyle(
                  color: Color.fromRGBO(255, 178, 0, 1.0),
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
