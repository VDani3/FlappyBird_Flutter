import 'package:flappybird_dj/componentes/bird.dart';
import 'package:flutter/material.dart';

class AppData {
  // Private constructor
  AppData._();

  // Singleton instance variable
  static final AppData _instance = AppData._();

  // Getter for the instance
  static AppData get instance => _instance;


  AppData._internal();

  List<Bird> playersList = [
    Bird(true, 0),
    Bird(false, 1),
    Bird(false, 2),
    Bird(false, 3)
  ];
  bool gameover = false;

  //Functions
  void setFainted(int id) {
    playersList[id].fainted = true;
  }

  void checkGameOver() {
    int num = 0; //Num of players fainted
    for (Bird b in playersList) {
      if (b.fainted) num += 1;
    }

    if (num >= 4) gameover = true;  //If all are fainted
  }
}
