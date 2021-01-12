import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:burger_game/burger-game.dart';

class LostView {
  final BurgerGame game;
  Rect rect;
  Sprite sprite;

  LostView(this.game) {
    resize();
    sprite = Sprite('bg/lose-splash.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void resize() {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
  }
}
