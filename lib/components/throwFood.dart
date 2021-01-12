import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:burger_game/burger-game.dart';
import 'package:burger_game/view.dart';

import '../burger-game.dart';

class ThrowFood {
  final BurgerGame game;
  Sprite flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  Rect foodRect;
  Rect deadZone;
  bool eating = false;
  bool isOffScreen = false;
  Offset targetLocation;

  bool broc = false;

  double get speed => game.tileSize * 10;

  double rotate = 0;

  bool destroy = false;

  ThrowFood(this.game) {
    targetLocation = Offset( game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 1.35)), game.screenSize.height - (game.screenSize.height / 1));
  }

  void setTargetLocation() {
    targetLocation = Offset( game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 1.35)), game.screenSize.height);
    destroy = true;
  }

  void render(Canvas c) {
    // print(game.screenSize.height);
    if (eating) {
      if( deadZone == null ) {
        deadZone = foodRect;
      }
      if( !broc ) {
        deadSprite.renderPosition(c, Position(deadZone.left, deadZone.top),size: Position( foodRect.width*2, foodRect.height*3));
      }

    } else {
      flyingSprite.renderRect(c, foodRect.inflate(foodRect.width / 4));
    }
  }

  void update(double t) {
    if (eating) {
      // make the fly fall

      rotate += 2* t;
      foodRect = foodRect.translate(0, game.tileSize * 12 * t);
      if (foodRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      // flap the wings
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      // move the fly
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(foodRect.left, foodRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        foodRect = foodRect.shift(stepToTarget);


      } else {
        foodRect = foodRect.shift(toTarget);

        if(destroy) {
          eating =  true;
        } else {
          setTargetLocation();
        }
      }
      // callout
      // callout.update(t);
    }
  }

  void resize() {}

  void onTapDown() {
    if (!eating) {
      eating = true;

      if (game.activeView == View.playing) {

        if(broc) {
            game.activeView = View.lost;
        } else {
          game.score += 1;
        }

      }
    }
  }
}
