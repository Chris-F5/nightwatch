import 'package:flutter/material.dart';
import 'search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nightwatch',
      home: SearchPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
