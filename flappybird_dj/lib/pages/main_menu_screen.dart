import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainMenu extends StatelessWidget {
  final GamePage game;
  static const String id = "mainMenu";

  const MainMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.fill
            )
          ),
          child: Image.asset(Assets.message),
        ),
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        }
      ),
    );
  }
}