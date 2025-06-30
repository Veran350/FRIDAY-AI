import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FridayAI());
}

class FridayAI extends StatelessWidget {
  const FridayAI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FRIDAY AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
