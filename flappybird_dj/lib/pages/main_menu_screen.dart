import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainMenu extends StatefulWidget {
  final GamePage game;
  static const String id = "mainMenu";

  MainMenu({Key? key, required this.game}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.game.pauseEngine();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  border: OutlineInputBorder()
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  if (AppData.instance.charging == false) {
                    AppData.instance.charging = true;
                    AppData.instance.initializeWebsocket(/*_ipController.text*/"localhost:8888", _nameController.text, widget.game);
                  }
                },
                child: Text('Dale')),
          ],
        ),
      ),
    );
  }
}
