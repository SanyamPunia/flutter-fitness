import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatsScreen extends StatefulWidget {
  final String workout;
  final Duration elapsedTime;
  final double caloriesBurned;
  final double distanceCovered;

  StatsScreen({
    required this.workout,
    required this.elapsedTime,
    required this.caloriesBurned,
    required this.distanceCovered,
  });

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<Map<String, dynamic>> savedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Stats', style: GoogleFonts.pacifico()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Workout: ${widget.workout}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildStatRow('Duration',
                '${widget.elapsedTime.inMinutes} mins ${widget.elapsedTime.inSeconds.remainder(60)} secs'),
            SizedBox(height: 10),
            _buildStatRow('Calories Burned',
                '${widget.caloriesBurned.toStringAsFixed(2)} kcal'),
            SizedBox(height: 10),
            _buildStatRow('Distance Covered',
                '${widget.distanceCovered.toStringAsFixed(2)} km'),
            SizedBox(height: 20),
            Text(
              'Calories Burned Over Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _buildCaloriesChart(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveWorkout,
              child: Text('Save Workout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCaloriesChart() {
    // Sample data for calories burned over time
    final List<charts.Series<dynamic, int>> seriesList = [
      charts.Series<dynamic, int>(
        id: 'Calories',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (dynamic _, int? index) => index!,
        measureFn: (dynamic _, int? index) => ((index! * 10) % 100).toDouble(),
        data: List.generate(10, (index) => index),
      ),
    ];

    return charts.LineChart(
      seriesList,
      animate: true,
    );
  }

  void _saveWorkout() {
    savedWorkouts.add({
      'workout': widget.workout,
      'dateTime': DateTime.now(),
      'duration': widget.elapsedTime,
      'caloriesBurned': widget.caloriesBurned,
      'distanceCovered': widget.distanceCovered,
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Workout saved')));
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
