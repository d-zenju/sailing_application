import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:sensors/sensors.dart';
//import 'package:location/location.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: PageController(viewportFraction: 1.0),
        scrollDirection: Axis.vertical,
        children: [CurrentTimePage(), DirectionPage()],
      ),
    );
  }
}


// コンパス表示Widget
class DirectionPage extends StatefulWidget {
  @override
  _DirectionPage createState() => _DirectionPage();
}

// コンパス表示
class _DirectionPage extends State<DirectionPage> {
  double _direction;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events.listen((double direction) {
      setState(() {
        _direction = direction;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_direction.toStringAsFixed(1) + '°', style: TextStyle(fontSize: 40.0)),
      ],
    );
  }
}

// 時間表示Widget
class CurrentTimePage extends StatefulWidget {
  @override
  _CurrentTimePage createState() => _CurrentTimePage();
}

// 時間表示
class _CurrentTimePage extends State<CurrentTimePage> {
  Timer _timer;
  DateFormat _dateFormat = DateFormat('HH:mm:ss');
  String _dateTime;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_t) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void updateTime() {
    _dateTime = _dateFormat.format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    updateTime();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$_dateTime', style: TextStyle(fontSize: 40.0)),
      ]);
  }
}