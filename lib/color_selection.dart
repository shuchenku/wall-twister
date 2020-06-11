import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:walltwister/colors.dart';
import 'package:walltwister/main.dart';

class ColorSelection extends StatefulWidget {

  final String title = 'Change Hold Colors';
  @override
  _ColorSelectionState createState() => _ColorSelectionState();
}


class _ColorSelectionState extends State<ColorSelection> {
  Map<String, double> dataMap = new Map();
  Map<String, Color> colorMap = new Map();
  List<Color> allColors;
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
    allColors = getAllColors();
    for (var i = 0; i < allColors.length; i++) {
      colorMap.putIfAbsent(allColors[i].toString(), () => allColors[i]);
      dataMap.putIfAbsent(allColors[i].toString(), () => 0);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    padding: EdgeInsets.all(24.0),
                      child: totalCount == 0 ? Text(
                        "Please add hold colors and adjust distribution.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 20,
//                          fontWeight: FontWeight.bold,
                        ),
                      ) : PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 800),
                        chartRadius: MediaQuery.of(context).size.width / 2,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: false,
                        chartValueBackgroundColor: Colors.grey[200],
                        colorList: allColors,
                        showLegends: false,
                        showChartValueLabel: true,
                        initialAngle: 0,
                        chartType: ChartType.disc,
                        chartValueStyle: defaultChartValueStyle.copyWith(
                          color: Colors.blueGrey[900].withOpacity(0.9),
                        ),
                      ),
                  ),
              Divider(
                color: Colors.amber,
                thickness: 2,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allColors.length,
                  itemBuilder: _buildItemsForListView)
              )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.green.withOpacity(0.5),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(colorMap: _getColorMap(), total: totalCount,)));
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
    );
  }

  Card _buildItemsForListView(BuildContext context, int index) {
    return Card(
        color: allColors[index],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.add_circle_outline, color: allColors[index] == Colors.black ? Colors.white30 : Colors.black45, size: 36),
              onPressed: () => _handleColorAdd(index),
              label: Text(""),
              color: Colors.transparent,
            ),
            FlatButton.icon(
              icon: Icon(Icons.remove_circle_outline, color: allColors[index] == Colors.black ? Colors.white30 : Colors.black45, size: 36),
              onPressed: () => _handleColorRemove(index),
              label: Text(""),
              color: Colors.transparent,
            ),
          ],
        )
    );
  }


  _handleColorAdd(int index) {
    if (dataMap.containsKey(allColors[index].toString())) {
      dataMap.update(allColors[index].toString(), (value) => value + 1);
    } else {
      dataMap.putIfAbsent(allColors[index].toString(), () => 1);
    }
    totalCount++;
    setState(() {

    });
  }

  _handleColorRemove(int index) {
    if (dataMap.containsKey(allColors[index].toString())) {
      dataMap.update(allColors[index].toString(), (value) => _handleCountOnRemove(value));
    }
    setState(() {

    });
  }

  double _handleCountOnRemove(double count) {
    if (count > 0) {
      totalCount--;
      return count - 1;
    } else {
      return 0;
    }
  }

  Map<Color, double> _getColorMap() {
    Map<Color, double> map = new Map();
    dataMap.forEach((key, value) {
      map.putIfAbsent(getColorFromString(key), () => value);
    });
    return map;
  }
}