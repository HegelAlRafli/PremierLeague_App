import 'package:flutter/material.dart';
import 'package:premierleague/detail.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:premierleague/home.dart';
import 'package:premierleague/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
    );
  }
}
