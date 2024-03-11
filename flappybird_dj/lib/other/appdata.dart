import 'package:flappybird_dj/componentes/bird.dart';
import 'package:flutter/material.dart';

class AppData {
  static AppData instance = AppData();

  AppData();

  //Variables
  List<Bird> playersList = [
    Bird(true, 0, false),
    Bird(false, 1, true),
    Bird(false, 2, true),
    Bird(false, 3, true)
  ];
  bool gameover = false;

  //Functions
  static AppData getInstance() {
    return instance;
  }

  void setFainted(int id) {
    playersList[id].fainted = true;
    checkGameOver();
  }

  void checkGameOver() {
    int num = 0; //Num of players fainted
    for (Bird b in playersList) {
      if (b.fainted) num += 1;
    }
    if (num >= 4) gameover = true; //If all are fainted
  }
}
