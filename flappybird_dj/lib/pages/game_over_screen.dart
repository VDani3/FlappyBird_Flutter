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
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              child: ListView.builder(
                itemCount: AppData.instance.playerScore.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/' + Assets.birdMidFlap[index],
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(width: 16,),
                        Text(
                          AppData.instance.playersName[index]
                        ),
                        SizedBox(width: 8,),
                        Text(
                          'Score: ${AppData.instance.playerScore[index]}',
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
            /* Text(
              "Score: ${game.bird.score}",
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontFamily: "Game",
              ),
            ),
            Image.asset(Assets.gameOver),
            const SizedBox(
              height: 20,
            ), */
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
    AppData.instance.resetGame();
    //game.resumeEngine();
  }
}
