import 'dart:convert';

import 'package:flappybird_dj/componentes/bird.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/material.dart';

import '../pages/websockets_manager.dart';

class AppData {
  static AppData instance = AppData();

  AppData();

  //Variables
  List<String> playersName = ['Pepe', 'Jose Roberto', 'Joel', 'Dani'];
  List<int> playerScore = [0, 0, 0, 0];
  List<Bird> playersList = [
    Bird(true, 0, false),
    Bird(false, 1, true),
    Bird(false, 2, true),
    Bird(false, 3, true)
  ];

  String name = "";
  bool gameover = false;
  late GamePage game;

  late WebSocketsHandler websocket;

  //Functions
  static AppData getInstance() {
    return instance;
  }

  String getPlayerInfo(id) {
    return playersList[id].name;
  }

  void resetGame() {
    for (int i = 0; i < playersList.length; i++) {
      playersList[i].reset();
    }
  }

  void getScore() {
    //Get each players score
    for (int i = 0; i < playersList.length; i++) {
      playerScore[i] = playersList[i].score + 0;
    }
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
    if (num >= 4) {
      //If all are fainted
      getScore();
      gameover = true;
    }
  }

  void initializeWebsocket(String serverIp, String name, GamePage g) {
    this.game = g;
    websocket = WebSocketsHandler();
    websocket.connectToServer(serverIp, name, serverMessageHandler);
    game.overlays.remove('mainMenu');
    game.overlays.add('waiting');
    AppData.instance.gameover = false;
  }

  void serverMessageHandler(String message) {
    print("Message recived: $message");

    final data = json.decode(message);

    if (data is Map<String, dynamic>) {
      if (data['type'] == 'loquesea') {
        // lo que hay que hacer
      }
    }
  }
}
