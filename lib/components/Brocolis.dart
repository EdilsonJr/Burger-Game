import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:burger_game/components/throwFood.dart';
import 'package:burger_game/burger-game.dart';

class Brocolis extends ThrowFood {
  double get speed => game.tileSize * 5;

  Brocolis(BurgerGame game, double x, double y) : super(game) {
    resize(x: x, y: y);
    flyingSprite = Sprite('flies/brocolis.png');
    deadSprite = Sprite('flies/brocolis.png');
    broc = true;
  }

  void resize({double x, double y}) {
    x ??= (foodRect?.left) ?? 0;
    y ??= (foodRect?.top) ?? 0;
    foodRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    super.resize();
  }
}
