import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import './home.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => home(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFF05F1FF),
          child: Center(
            child: Image(
              image: AssetImage("assets/pemierleaguelogo.png"),
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
      ),
    );
  }
}
