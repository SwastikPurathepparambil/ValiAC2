import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserDataStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userData.txt').create(recursive: true);;
  }

  Future<String> readCounter() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      print("***local file state contents=$contents");

      return contents;
    } catch (e) {
      print(e);
      // If encountering an error, return 0
      return "Error";
    }
  }

  Future<File> writeCounter(String counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(counter);
  }
}