import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountDown extends StatefulWidget {
  final GamePage game;
  const CountDown({Key? key, required this.game}) : super(key: key);

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TweenAnimationBuilder<Duration>(
            duration: Duration(seconds: 4),
            tween: Tween(begin: Duration(seconds: 4), end: Duration.zero),
            onEnd: () {
              widget.game.overlays.remove('countdown');
              widget.game.resumeEngine();
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              final seconds = value.inSeconds % 60;
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('$seconds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Game',
                          fontSize: 80)));
            }),
      ),
    );
  }
}
