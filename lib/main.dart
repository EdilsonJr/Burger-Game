import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:burger_game/burger-game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  await Flame.images.loadAll(<String>[
    'flies/brocolis.png',
    'flies/burger.png',
    'flies/eating.png',
    'bg/backyard.png',
    'bg/lose-splash.png',
    'branding/title.png',
    'ui/start-button.png',
  ]);
  

  BurgerGame game = BurgerGame();
  runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);

}
