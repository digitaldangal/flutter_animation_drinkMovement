import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.light(),
      title: 'Animation Drink',
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      vsync: this,
      duration: new Duration(
        seconds: 3,
      ),
    );
    animation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          child: new CustomPaint(
            painter: new Artboard(
              value: animation.value,
            ),
          ),
        ),
      ),
    );
  }
}

class Artboard extends CustomPainter {
  Artboard({this.value});

  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    // paint something

    //cup upper circle top
    var drawOval1 = new Paint()..color = Colors.amber[100];
    canvas.drawArc(new Rect.fromLTWH(-50.0, 15.0, 100.0, 30.0), 0.0, -math.pi,
        true, drawOval1);

    //cup body
    var drawRect = new Paint()..color = Colors.amberAccent[100];
    canvas.drawRect(
      new Rect.fromLTWH(-50.0, 30.0, 100.0, 200.0),
      drawRect,
    );

    //cup bottom
    var drawbottom = new Paint()..color = Colors.amberAccent[100];
    canvas.drawOval(new Rect.fromLTWH(-50.0, 210.0, 100.0, 40.0), drawbottom);

    //cup drawstick
    var drawPath = new Paint()..color = Colors.cyan[700];
    var path = new Path();
    //vertical line
    path.addRect(new Rect.fromLTWH(-5.0, -30.0, 10.0, 210.0));
    //honrizontal line
    path.addRect(new Rect.fromLTWH(5.0, -40.0, 70.0, 10.0));

    canvas.drawPath(path, drawPath);

    //drawstick month

    var drawStickMonth = new Paint()..color = Colors.lightGreen[300];
    canvas.drawCircle(new Offset(75.0, -35.0), 5.0, drawStickMonth);

    //cup drawstick curve
    var drawArc = new Paint()..color = Colors.cyan[100];
    canvas.drawArc(
      new Rect.fromCircle(center: new Offset(5.0, -30.0), radius: 10.0),
      -math.pi / 2,
      -math.pi / 2,
      true,
      drawArc,
    );

    //cup upper circle bottom
    var drawOval2 = new Paint()..color = Colors.amber[100];
    canvas.drawArc(new Rect.fromLTWH(-50.0, 15.0, 100.0, 30.0), 0.0, math.pi,
        true, drawOval2);

    // canvas.rotate(math.pi / 2);
    // canvas.scale(0.5+0.5*value, 0.5+0.5*value);

    //water
    var waterPaint = new Paint()..color = const Color.fromRGBO(1, 2, 180, 0.5);
    var waterPath = new Path();
    waterPath.addRect(new Rect.fromLTWH(-40.0, 70.0+value*70, 80.0, 150.0-value*70));
    waterPath.addOval(new Rect.fromLTWH(-40.0, 200.0, 80.0, 40.0));
    waterPath.addArc(
        new Rect.fromLTWH(-40.0, 55.0+value*70, 80.0, 30.0), math.pi, -math.pi);

    canvas.drawPath(waterPath, waterPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
