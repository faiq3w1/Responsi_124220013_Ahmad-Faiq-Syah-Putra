import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AmiiboApp());
}

class AmiiboApp extends StatelessWidget {
  const AmiiboApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nintendo Amiibo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          const HomeScreen(), // Start with HomeScreen or whichever screen you want
    );
  }
}
