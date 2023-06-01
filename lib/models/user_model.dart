import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserData extends ChangeNotifier {
  String _email = "";
  String _userName = "";
  String get userEmail => _email;
  String get userName => _userName;

  void updateEmail(String updatedEmail) {
    _email = updatedEmail;
    notifyListeners();
  }

  String getEmail() {
    return _email;
  }

  void updateName(String updatedName) {
    _userName = updatedName;
    notifyListeners();
  }
}

// class Data extends ChangeNotifier {
//   Map data = {
//     'name': 'Sammy Shark',
//     'email': 'example@example.com',
//     'age': 42
//   };
//
//   void updateAccount(input) {
//     data = input;
//     notifyListeners();
//   }
// }