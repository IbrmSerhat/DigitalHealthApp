import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'other screen/splash_screen.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(canvasColor: Color.fromARGB(255, 36, 19, 60)),
    home: SplashScreen(),
  ));
}
