import 'package:dandy/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Dandy());
}

class Dandy extends StatelessWidget {
  const Dandy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
