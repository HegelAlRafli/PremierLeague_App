import 'package:flutter/material.dart';
import 'package:premierleague/page/detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:premierleague/page/fav.dart';

import 'package:premierleague/page/home.dart';
import 'package:premierleague/page/splashscreen.dart';

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
      home: home(),
    );
  }
}
