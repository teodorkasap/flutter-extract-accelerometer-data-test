import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'ui/sensorDataCard.dart';

class RecordingScreen extends StatefulWidget {
  final String shotType;
  const RecordingScreen({super.key, required this.shotType});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  // 1. Define storage for your data
  AccelerometerEvent? _accelEvent;
  GyroscopeEvent? _gyroEvent;

  // 2. Stream subscriptions to manage the listeners
  StreamSubscription<AccelerometerEvent>? _accelSubscription;
  StreamSubscription<GyroscopeEvent>? _gyroSubscription;

  @override
  void initState() {
    super.initState();

    // 3. Start listening to Accelerometer
    _accelSubscription = accelerometerEventStream().listen((event) {
      setState(() => _accelEvent = event);
    });

    // 4. Start listening to Gyroscope
    _gyroSubscription = gyroscopeEventStream().listen((event) {
      setState(() => _gyroEvent = event);
    });
  }

  @override
  void dispose() {
    // 5. IMPORTANT: Always cancel sensors when leaving the screen
    _accelSubscription?.cancel();
    _gyroSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final xAccel = _accelEvent?.x.toStringAsFixed(3) ?? "0.000";
    final yAccel = _accelEvent?.y.toStringAsFixed(3) ?? "0.000";
    final zAccel = _accelEvent?.z.toStringAsFixed(3) ?? "0.000";

    final xGyro = _gyroEvent?.x.toStringAsFixed(3) ?? "0.000";
    final yGyro = _gyroEvent?.y.toStringAsFixed(3) ?? "0.000";
    final zGyro = _gyroEvent?.z.toStringAsFixed(3) ?? "0.000";

    return Scaffold(
      appBar: AppBar(
        title: Text('Recording ${widget.shotType}'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Accelerometer (m/s²)",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SensorDataCard(
                label: 'X (Horizontal)', value: xAccel.toString(), color: Colors.red),
            const SizedBox(height: 10),
            SensorDataCard(
                label: 'Y (Vertical)', value: yAccel.toString(), color: Colors.green),
            const SizedBox(height: 10),
            SensorDataCard(label: 'Z (Depth)', value: zAccel.toString(), color: Colors.blue),
            // const SizedBox(height: 40),
            const Divider(height: 40),
            const Text("Gyroscope (rad/s)",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SensorDataCard(
                label: 'X (Horizontal)', value: xGyro.toString(), color: Colors.red),
            const SizedBox(height: 10),
            SensorDataCard(
                label: 'Y (Vertical)', value: yGyro.toString(), color: Colors.green),
            const SizedBox(height: 10),
            SensorDataCard(label: 'Z (Depth)', value: zGyro.toString(), color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
