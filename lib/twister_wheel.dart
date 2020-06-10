import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';


class TwisterWheel extends StatefulWidget {
  final List<Color> colorList;

  TwisterWheel({Key key, this.colorList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TwisterWheelState();

}

class _TwisterWheelState extends State<TwisterWheel> {
  final StreamController _dividerController = StreamController<int>();
  final _wheelNotifier = StreamController<double>();

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinningWheel(
        Image.asset('assets/images/arrow.png'),
        width: 320,
        height: 320,
        initialSpinAngle: _generateRandomAngle(),
        spinResistance: 0.6,
        canInteractWhileSpinning: false,
        dividers: 8,
        onUpdate: _dividerController.add,
        onEnd: _dividerController.add,
        shouldStartOrStop: _wheelNotifier.stream,
      ),
    );
  }
}