import 'package:flutter/material.dart';

// A reusable UI component for showing the data
class SensorDataCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const SensorDataCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(Icons.speed, color: color),
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}