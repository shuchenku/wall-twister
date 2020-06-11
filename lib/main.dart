import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:walltwister/radial_widget.dart';

import 'color_selection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wall Twister',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  final Map<Color, double> colorMap;
  final String title = "Wall Twister";
  final total;

  MyHomePage({Key key, this.colorMap, this.total}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors;

  @override
  void initState() {
    super.initState();
    if (widget.colorMap == null || widget.colorMap.isEmpty) {
      colors = _getDefaultColors();
    } else {
      colors = new List();
      widget.colorMap.forEach((key, value) {
        int count = value.floor();
        if (widget.total != 0) {
          count = (value/widget.total*10).round();
        }
        for (var i = 0; i < count; i++) {
          colors.add(key);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        color: Colors.amber[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/lh.png',
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text("Left Hand"),
                    ]
                ),
                Spacer(flex: 5,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/rh.png',
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text("Right Hand"),
                  ],
                ),
                Spacer(),
              ],
            ),
            Center(
                child: RadialWidget((colors == null || colors.isEmpty) ? _getDefaultColors() : colors)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Left Foot'),
                    Image.asset(
                      'assets/images/lf.png',
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ],
                ),
                Spacer(flex: 5,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Right Hand'),
                    Image.asset(
                      'assets/images/rf.png',
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ],
                ),

                Spacer(),
              ],
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.height * 0.25,
                height: MediaQuery.of(context).size.height * 0.05,
                child: RaisedButton(
                    child: AutoSizeText(
                        "Change Hold Colors",
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.red,
                    textColor: Colors.amberAccent,
                    onPressed: () =>
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => ColorSelection()))
                ),
              )
            ),
          ],
        ),
      )
    );
  }

  List<Color> _getDefaultColors() {
    List<Color> colors = new List<Color>();
    colors.add(Colors.green);
    colors.add(Colors.green);
    colors.add(Colors.red);
    colors.add(Colors.red);
    colors.add(Colors.blue);
    colors.add(Colors.blue);
    colors.add(Colors.yellow);
    colors.add(Colors.yellow);
    colors.add(Colors.orange);
    colors.add(Colors.orange);
    return colors;
  }
}
