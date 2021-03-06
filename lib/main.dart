import 'dart:ui';
import 'package:flutter/material.dart';

//importing screens
import 'package:project_os/screens/page/pageHome.dart';

//importing components
import './screens/page/components/materialButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  //Animations
  AnimationController _controller;
  Animation<double> _animation;
  CurvedAnimation _curve;

  //background and button color
  var primaryColor = Color(0xFFEFF3F6);

  double topPosition, leftPosition;

  @override
  void initState() {
    super.initState();
    textAnimate();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_curve);

    fadeAnimate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void fadeAnimate() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _controller.animateTo(1.0);
    });
  }

  void textAnimate() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      topPosition = 40;
      leftPosition = 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) => Scaffold(
              body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Stack(alignment: Alignment.center, children: [
              AnimatedPositioned(
                top: topPosition == null
                    ? MediaQuery.of(context).size.height / 2
                    : topPosition,
                left: leftPosition == null
                    ? MediaQuery.of(context).size.width / 2 - 70
                    : leftPosition,
                duration: Duration(milliseconds: 800),
                child: Container(
                  child: Text(
                    "OS LAB",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                  top: 82,
                  left: 33,
                  child: FadeTransition(
                      opacity: _animation,
                      child: Text(
                        "3 Teams  11 Members",
                        style: TextStyle(
                            color: Color(0xff606060),
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ))),
              FadeTransition(
                opacity: _animation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Choose Your Task",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff606060)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonMat(
                          boxHeight: 150,
                          boxWidth: 150,
                          text: "Page Replacement",
                          iconName: Icon(Icons.file_copy,
                              color: Color(0xFF5DA3FA), size: 35),
                          textColor: Color(0xFF5DA3FA),
                          pressButton: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageHome()));
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ]),
          )),
        ));
  }
}
