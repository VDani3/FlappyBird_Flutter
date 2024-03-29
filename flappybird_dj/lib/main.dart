import 'package:flame/game.dart';
import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flappybird_dj/pages/countdown_screen.dart';
import 'package:flappybird_dj/pages/game_over_screen.dart';
import 'package:flappybird_dj/pages/main_menu_screen.dart';
import 'package:flappybird_dj/pages/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final appData = AppData(); // Create an instance of AppData
  final gamePage = GamePage();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => appData, // Provide the instance of AppData
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GameWidget(
          game: gamePage,
          initialActiveOverlays: const [MainMenu.id],
          overlayBuilderMap: {
            'mainMenu': (context, _) => MainMenu(game: gamePage),
            'gameOver': (context, _) => GameOverScreen(game: gamePage),
            'countdown': (context, _) => CountDown(game: gamePage),
            'waiting': (context, _) => WaitingRoom(
              game: gamePage,
            )
          },
        ),
      ),
    ),
  );
}
