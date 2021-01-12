import 'package:burger_game/components/throwFood.dart';
import 'package:burger_game/burger-game.dart';

class FlySpawner {
  final BurgerGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 300;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 5;
  int currentInterval;
  int nextSpawn;

  FlySpawner(this.game) {
    start();
    game.spawnFood();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.foods.forEach((ThrowFood food) => food.eating = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    game.foods.forEach((ThrowFood food) {
      if (!food.eating) livingFlies += 1;
    });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnFood();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
