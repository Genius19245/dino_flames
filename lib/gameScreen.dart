import 'package:dino_flames/game/utils/audioManager.dart';
import 'package:dino_flames/splashscreen.dart';
import 'package:flame/game.dart' show GameWidget;
import 'package:flutter/material.dart';
import '../game/game.dart';

final dino = DinoGame();

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const GameScreen(),
    );
  }

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GameWidget(game: DinoGame()),
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  '',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(SplashScreen.route());
                    dino.reset();
                  },
                  child: Text(
                    'Replay',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
