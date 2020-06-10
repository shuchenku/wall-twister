import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:walltwister/twister_wheel.dart';

class RadialWidget extends StatefulWidget {
  final List<Color> colorList;

  const RadialWidget(this.colorList, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RadialWidget();
}


class _RadialWidget extends State<RadialWidget> {

  final double radius = 320.0;

  List<Widget> getCircles() {
    double radian = pi / 2 / widget.colorList.length;
    var circles = new List<Widget>();
    double sradius = pi*60/widget.colorList.length;
    double bradius = radius/2 - sradius;

    Widget bigCircle = new Container(
      width: radius + 10,
      height: radius + 10,
      decoration: new BoxDecoration(
        color: Colors.black12,
        shape: BoxShape.circle,
      ),
    );

    circles.add(bigCircle);

    for (var i = 0; i < widget.colorList.length; i++) {
      circles.add(
        Positioned(
          child: new CircleButton(widget.colorList[i], sradius),
          bottom: radius/2 + sin(radian * (0.5 + i)) * bradius,
          right: radius/2 + cos(radian * (0.5 + i)) * bradius,
        ),
      );
    }

    for (var i = widget.colorList.length; i > 0; i--) {
      circles.add(
        Positioned(
          child: new CircleButton(widget.colorList[widget.colorList.length - i], sradius),
          bottom: radius/2 + sin(radian * (i - 0.5)) * bradius,
          left: radius/2 + cos(radian * (i - 0.5)) * bradius,
        ),
      );
    }

    for (var i = 0; i < widget.colorList.length; i++) {
      circles.add(
        Positioned(
          child: new CircleButton(widget.colorList[i], sradius),
          top: radius/2 + sin(radian * (0.5 + i)) * bradius,
          left: radius/2 + cos(radian * (0.5 + i)) * bradius,
        ),
      );
    }

    for (var i = widget.colorList.length; i >0; i--) {
      circles.add(
        Positioned(
          child: new CircleButton(widget.colorList[widget.colorList.length - i], sradius),
          top: radius/2  + sin(radian * (i - 0.5)) * bradius,
          right: radius/2  + cos(radian * (i - 0.5)) * bradius,
        ),
      );
    }

    circles.add(
        Positioned(
          child: TwisterWheel(),
          bottom: -75,
          left: 8,
        )
    );

    return circles;
  }

  @override
  Widget build(BuildContext context) {

    return new Material(
      color: Colors.amber[100],
      child: new Center(
        child: new Stack(
          children: getCircles()
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final Color color;
  final double size;

  const CircleButton(this.color, this.size, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new InkResponse(
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}