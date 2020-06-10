import 'dart:ui';

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

  MyHomePage({Key key, this.colorMap}) : super(key: key);

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
        for (var i = 0; i < value; i++) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/lh.png',
                        width: 80,
                      ),
                      Text("Left Hand"),
                    ]
                ),
                Spacer(flex: 5,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/rh.png',
                      width: 80,),
                    Text("Right Hand"),
                  ],
                ),
                Spacer(),
              ],
            ),
            Center(
                child: RadialWidget(colors ?? _getDefaultColors())
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
                      width: 50,
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
                      width: 50,
                    ),
                  ],
                ),

                Spacer(),
              ],
            ),
            Center(
              child: Container(
                width: 150,
                height: 60,
                child: new RaisedButton(
                    child: new Text(
                        "New Game",
                        style: new TextStyle(fontSize: 20)
                    ),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.red,
                    textColor: Colors.amberAccent,
                    onPressed: () =>
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => ColorSelection()))
                ),
              )
            ),
            Spacer(),
          ],
        ),
      )
    );
  }

  List<Color> _getDefaultColors() {
    List<Color> colors = new List<Color>();
    colors.add(Colors.green);
    colors.add(Colors.red);
    colors.add(Colors.blue);
    colors.add(Colors.yellow);
    return colors;
  }
}
