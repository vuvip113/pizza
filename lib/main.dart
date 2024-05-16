import 'package:flutter/material.dart';
import 'package:pizza/ui/home/home.dart';
import 'package:pizza/common/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: kcDarkGreyColor),
      ),
      home: const Home(),
    );
  }
}
