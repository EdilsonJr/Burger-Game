import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:burger_game/burger-game.dart';

class HomeView {
  final BurgerGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    resize();
    titleSprite = Sprite('flies/eating.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void resize() {
    titleRect = Rect.fromLTWH(
      game.tileSize + 11,
      (game.screenSize.height / 2) - (game.tileSize * 6.7),
      game.tileSize * 7,
      game.tileSize * 7,
    );
  }
}
