import 'package:flutter/material.dart';
import 'ui/shot_button.dart'; // Import the new widget
import 'selection_screen.dart';

void main() {
  runApp(const SensorApp());
}

class SensorApp extends StatelessWidget {
  const SensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const SelectionScreen(),
    );
  }
}
