import 'package:flutter/material.dart';
import 'package:kurdish_names/screens/kurdish_names_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: GoogleFonts.notoSansArabic().fontFamily),
      home: KurdishNamesList(),
    );
  }
}
