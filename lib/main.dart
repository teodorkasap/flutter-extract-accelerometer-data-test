import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const SensorApp());
}

class SensorApp extends StatelessWidget {
  const SensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Accelerator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const AccelerometerScreen(),
    );
  }
}

class AccelerometerScreen extends StatefulWidget {
  const AccelerometerScreen({super.key});

  @override
  State<AccelerometerScreen> createState() => _AccelerometerScreenState();
}

class _AccelerometerScreenState extends State<AccelerometerScreen> {
  // We use a List to store the x, y, z values
  List<double>? _accelerometerValues;
  
  // Stream subscription to cancel when the widget is destroyed
  StreamSubscription<AccelerometerEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    // Start listening to the accelerometer stream
    _subscription = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        setState(() {
          _accelerometerValues = <double>[event.x, event.y, event.z];
        });
      },
      onError: (error) {
        // Handle cases where the sensor might not be available
        debugPrint("Sensor Error: $error");
      },
    );
  }

  @override
  void dispose() {
    // Crucial: Stop listening when the app closes to save battery/memory
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract values or default to 0.0
    final x = _accelerometerValues?[0] ?? 0.0;
    final y = _accelerometerValues?[1] ?? 0.0;
    final z = _accelerometerValues?[2] ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer Tracker'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SensorDataCard(label: 'X (Horizontal)', value: x, color: Colors.red),
              const SizedBox(height: 10),
              SensorDataCard(label: 'Y (Vertical)', value: y, color: Colors.green),
              const SizedBox(height: 10),
              SensorDataCard(label: 'Z (Depth)', value: z, color: Colors.blue),
              const SizedBox(height: 40),
              const Text(
                'Move your device (or use Emulator Extended Controls) to see the numbers change!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A reusable UI component for showing the data
class SensorDataCard extends StatelessWidget {
  final String label;
  final double value;
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
          value.toStringAsFixed(3),
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