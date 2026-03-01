import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'ui/sensorDataCard.dart';


class AccelerometerScreen extends StatefulWidget {
  final String shotType;
  const AccelerometerScreen({super.key, required this.shotType});

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
        title: Text('Recording ${widget.shotType}'),
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