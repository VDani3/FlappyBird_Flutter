import 'dart:convert';
import 'dart:ui_web';

import 'package:flappybird_dj/componentes/bird.dart';
import 'package:flutter/material.dart';

import '../pages/websockets_manager.dart';

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

  late WebSocketsHandler websocket;

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

  void initializeWebsocket(String serverIp) {
    websocket = WebSocketsHandler();
    websocket.connectToServer(serverIp, serverMessageHandler);
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
