import 'package:flutter/material.dart';

class EmotionsModel {
  String emotion;
  String name;

  EmotionsModel({required this.emotion, required this.name});

  EmotionsModel.fromJson(Map<String, dynamic> parsedJSON)
      : emotion = parsedJSON['emotion'],
        name = parsedJSON['name'];
}