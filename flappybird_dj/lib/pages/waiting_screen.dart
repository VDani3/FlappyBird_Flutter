import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingRoom extends StatefulWidget {
  final GamePage game;

  const WaitingRoom({Key? key, required this.game}) : super(key: key);

  @override
  _WaitingRoomState createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  bool _waiting = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppData data = Provider.of<AppData>(context);
    if (data.playersList.length == 4) {
      setState(() {
        _waiting = true;
      });
      widget.game.overlays.remove('mainMenu');
      widget.game.overlays.add('waiting');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _waiting ? Text('Waiting...') : Container(),
      ),
    );
  }
}