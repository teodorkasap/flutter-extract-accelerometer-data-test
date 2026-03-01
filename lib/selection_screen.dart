import 'accelerometer_screen.dart';
import 'recording_screen.dart';
import 'ui/shot_button.dart';
import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  // A helper method to keep the build method clean
  void _goToRecording(BuildContext context, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecordingScreen(shotType: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swing Tracker'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShotButton(
              label: 'Forehand',
              color: Colors.orange,
              onPressed: () => _goToRecording(context, 'Forehand'),
            ),
            const SizedBox(height: 20),
            ShotButton(
              label: 'Backhand',
              color: Colors.blue,
              onPressed: () => _goToRecording(context, 'Backhand'),
            ),
          ],
        ),
      ),
    );
  }
}