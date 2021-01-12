import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:burger_game/components/Burger.dart';
import 'package:burger_game/components/backyard.dart';
import 'package:burger_game/components/Brocolis.dart';
import 'package:burger_game/components/throwFood.dart';
import 'package:burger_game/components/score-display.dart';
import 'package:burger_game/components/start-button.dart';
import 'package:burger_game/controllers/spawner.dart';
import 'package:burger_game/view.dart';
import 'package:burger_game/views/home-view.dart';
import 'package:burger_game/views/lost-view.dart';

class BurgerGame extends Game {
  Size screenSize;
  double tileSize;
  Random rnd;

  Backyard background;
  List<ThrowFood> foods;
  StartButton startButton;
  ScoreDisplay scoreDisplay;

  FlySpawner spawner;

  View activeView = View.home;
  HomeView homeView;
  LostView lostView;

  int score;

  BurgerGame() {
    initialize();
  }

  Future<void> initialize() async {
    rnd = Random();
    foods = List<ThrowFood>();
    score = 0;
    resize(Size.zero);

    background = Backyard(this);
    startButton = StartButton(this);
    scoreDisplay = ScoreDisplay(this);

    spawner = FlySpawner(this);
    homeView = HomeView(this);
    lostView = LostView(this);

  }

  void spawnFood() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
    //double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.025))) + (tileSize * 1.5);
    double y = screenSize.height - (tileSize * 2.025);
    switch (rnd.nextInt(2)) {
      case 0:
        foods.add(Brocolis(this, x, y));
        break;
      case 1:
        foods.add(Burger(this, x, y));
        break;
    }
  }

  void render(Canvas canvas) {
    background.render(canvas);

    if (activeView == View.playing || activeView == View.lost) scoreDisplay.render(canvas);

    foods.forEach((ThrowFood fly) => fly.render(canvas));

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
    }
  }

  void update(double t) {
    spawner.update(t);
    foods.forEach((ThrowFood fly) => fly.update(t));
    foods.removeWhere((ThrowFood fly) => fly.isOffScreen);
    if (activeView == View.playing) scoreDisplay.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;

    background?.resize();
    scoreDisplay?.resize();
    foods.forEach((ThrowFood fly) => fly?.resize());

    homeView?.resize();
    lostView?.resize();

    startButton?.resize();

  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // dialog boxes
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    // start button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // flies
    if (!isHandled) {
      bool didHitAFly = false;
      foods.forEach((ThrowFood fly) {
        if (fly.foodRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;
          didHitAFly = true;
        }
      });

    }
  }
}
