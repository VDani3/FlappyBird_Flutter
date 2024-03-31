import 'package:flappybird_dj/componentes/pipe_group.dart';
import 'package:flappybird_dj/other/appdata.dart';
import 'package:flappybird_dj/other/assets.dart';
import 'package:flappybird_dj/pages/GamePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameOverScreen extends StatelessWidget {
  final GamePage game;
  static const String id = 'gameOver';

  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              child: ListView.builder(
                itemCount: AppData.instance.playerScore.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/' + Assets.birdMidFlap[index],
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          AppData.instance.getPlayerName(index),
                          style: TextStyle(
                            fontSize: 40,
                            color: Assets.fontColors[index],
                            fontFamily: "Game",
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${AppData.instance.getPlayerScore(index)}p',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontFamily: "Game",
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: restartGame,
                child: const Text(
                  "END",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }

  void restartGame() {
    game.overlays.add('mainMenu');
    game.overlays.remove('gameOver');
    game.resetGame();
    AppData.instance.resetGame();
  }
}
