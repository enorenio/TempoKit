import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart' as loader;

Widget loadingWidget = Scaffold(
  body: Center(
    child: loader.Loading(
      indicator: BallSpinFadeLoaderIndicator(),
      size: 40.0,
    ),
  ),
);