//Pa codigo mas limpio

import 'package:flutter/material.dart';

class Assets {
  //Background Assets
  static const background = "background.png";
  static const ground = "ground.png";
  static const clouds = "clouds.png";
  static const pipe = "pipe.png";
  static const pipeRotated = "pipe_rotated.png";

  //Bird Assets
  static const birdMidFlap = [
    "bird_midflap.png",
    "bird_midflap.png",
    "bird_midflap.png",
    "bird_midflap.png"
  ];
  static const birdUpFlap = [
    "bird_upflap.png",
    "bird_upflap.png",
    "bird_upflap.png",
    "bird_upflap.png"
  ];
  static const birdDownFlap = [
    "bird_downflap.png",
    "bird_downflap.png",
    "bird_downflap.png",
    "bird_downflap.png"
  ];

  //UI Assets
  static const gameOver = "assets/images/gameover.png";
  static const menu = "assets/images/menu.jpg";
  static const message = "assets/images/message.png";

  //Sound Assets
  static const flying = 'fly.wav';
  static const collision = 'collision.wav';
  static const point = 'point.wav';

  //Font Colors
  static const fontColors = [
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.green
  ];
}
