import 'package:flutter/material.dart';

class QuizLevel with ChangeNotifier {
  int triesLeft = 3;
  int MovePage = 0;
  String TriesLeft() {
    return triesLeft.toString();
  }

  void startGame() {
    triesLeft = 3;
    MovePage = 0;
  }

  void WrongAns() {
    --triesLeft;
    notifyListeners();
  }

  void RightAns() {
    MovePage++;
    notifyListeners();
  }
}
