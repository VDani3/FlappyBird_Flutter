import 'dart:js';

import 'package:flame/game.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flappybird_dj/pages/game_over_screen.dart';
import 'package:flappybird_dj/pages/main_menu_screen.dart';
import 'package:flutter/material.dart';

void main() {

  final gamePage = GamePage();
  runApp(
    GameWidget(
      game: gamePage,
      initialActiveOverlays: const [MainMenu.id],
      overlayBuilderMap: {
        'mainMenu': (context, _) => MainMenu(game: gamePage),
        'gameOver': (context, _) => GameOverScreen(game: gamePage)
      },
    )
  );
}

