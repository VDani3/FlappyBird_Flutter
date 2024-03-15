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
  Widget build(BuildContext context) {
    AppData data = AppData.instance;

    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: data.playersList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Player $index'),
                SizedBox(width: 20,),
                Text(data.getPlayerName(index) == "" ? "Waiting..." : data.getPlayerName(index)),
              ],
            ),
          );
        },
      )),
    );
  }
}
