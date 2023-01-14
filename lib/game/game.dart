import 'package:dino_flames/game/enemy.dart';
import 'package:dino_flames/game/flutter.dart';
import 'package:dino_flames/game/player.dart';
import 'package:dino_flames/game/utils/audioManager.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';

class DinoGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection, TapDetector {
  // variable for player from Player class
  late Player player;
  // variable for Enemy from Enemy class
  late Enemy enemy;
  // variable for Flutter from Flutter class
  late Flutter flutter;
  // variable for displaying score
  final _scoreText = TextComponent();
  //variable for displaying health
  final _healthText = TextComponent();
  // Variable for keeping health value
  final health = ValueNotifier<int>(10);
  // variable for finding out ground for the game
  late double ground = size.y - 150;
  // Variable for keeping track of the score
  int score = 0;
  // Timer Variable
  late Timer interval;
  // Images passed through for parallax. Add more layers to Parallax here:
  final _imageNames = [
    ParallaxImageData(
      'mari.jpeg',
    ),
    // ParallaxImageData('pin.png'),
    // ParallaxImageData('base1.png'),
    // ParallaxImageData('grass.png'),
  ];

  DinoGame() {
    interval = Timer(
      2,
      onTick: () => score += 10,
      repeat: true,
    );
  }

  @override
  // When Game is loading, this method is called
  Future<void>? onLoad() async {
    // Inititalises the Audio
    AudioManager.init();
    //Plays The Background music
    AudioManager.playMusic('laser.mp3', 'lasers.mp3');
    // TODO: implement onLoad
    // Declaring Parallax Component
    final parallax = await loadParallaxComponent(
      _imageNames,
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
    );
    // Adding Parallax Component To This Game
    add(parallax);
    // Adds The Enemy To The game
    add(enemy = Enemy(sprite: await loadSprite('water.png')));
    // Adds The Flutter Power up To the game
    add(flutter = Flutter(sprite: await loadSprite('flutter.png')));
    // Adds The Player Component To The Game
    add(player = Player(sprite: await loadSprite('dashatar.png')));
    //Adds the Score text to the game
    add(_scoreText
      ..size = Vector2(75.5, 75.5)
      ..position = Vector2(15.0, 26.0));
    //adds the health Text to game
    add(
      _healthText
        ..size = Vector2(75.5, 75.5)
        ..position = Vector2(size.x - 26.0, 26.0)
        ..anchor = Anchor.topRight,
    );
    // Adds a listener for the health variable and tells it to update the health
    health.addListener(_updateHealthText);
    _updateHealthText();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _healthText.x = size.x - 26.0;
    // TODO: implement update
    super.update(dt);
    // Sets The Ground Of the Game depending on the window size
    ground = size.y - 250;
    // function to update Score Text
    _updateScoreText();
    // Updates Timer For Score
    interval.update(dt);
    // Updates Score Text With The Score Variable
    _scoreText.text = "Score: $score ";
    // Code to Check when Game ends
    if (health.value < 1) {
      pauseEngine();
    }
  }

  @override
  void onTap() {
    // TODO: implement onTap
    player.jump();
    super.onTap();
  }

// Function to update Score Text
  void _updateScoreText() {
    _scoreText.text = 'Score: ${score.toInt()}';
  }

// function to Update Health Text
  void _updateHealthText() {
    _healthText.text = 'health: ${health.value.toInt()}';
  }

  // Function when called resets all variable
  void reset() {
    _scoreText
      ..size = Vector2(75.5, 75.5)
      ..position = Vector2(15.0, 26.0)
      ..text = 'Score: 0';
    score = 0;
    _healthText
      ..size = Vector2(75.5, 75.5)
      ..position = Vector2(15.0, 26.0)
      ..text = 'health: 5';
    health.value = 5;
  }
}
