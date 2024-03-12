import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainMenu extends StatelessWidget {
  final GamePage game;
  static const String id = "mainMenu";

  MainMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _ipController = TextEditingController();
    game.pauseEngine();

    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Flappy Bird',
              style: TextStyle(fontFamily: 'Game', fontSize: 80),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 250,
              height: 100,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Player Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: 250,
              height: 100,
              child: TextField(
                controller: _ipController,
                decoration: InputDecoration(
                  labelText: 'IP:Port',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  AppData.instance.initializeWebsocket(_ipController.text);
                  game.overlays.remove('mainMenu');
                  game.overlays.add('waiting');
                  AppData.instance.gameover = false;
                },
                child: Text('Dale'))
          ],
        ),
      ),
    );
  }
}
