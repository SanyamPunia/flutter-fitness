import 'package:fitness_tracker_app/screens/save_progress_widget.dart';
import 'package:fitness_tracker_app/screens/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimerScreen extends StatefulWidget {
  final String workout;

  TimerScreen({required this.workout});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Stopwatch _stopwatch;
  late Duration _elapsed;
  double _caloriesBurnedPerMinute = 10.0; // Initial calorie burn rate per minute
  double _distanceCoveredPerMinute = 0.1; // Initial distance covered per minute (in km)
  bool _isRunning = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _elapsed = Duration.zero;
  }

  void _startStopTimer() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _isRunning = false;
        _isPaused = true;
        _showSaveDialog();
      } else {
        _stopwatch.start();
        _isRunning = true;
        _updateTime();
      }
    });
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {
      _elapsed = Duration.zero;
      _isRunning = false;
      _isPaused = false;
    });
  }

  void _updateTime() {
    if (_stopwatch.isRunning) {
      setState(() {
        _elapsed = _stopwatch.elapsed;
      });
      Future.delayed(Duration(seconds: 1), _updateTime);
    }
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SaveProgressWidget(
          onSave: () {
            // Save workout progress
            Navigator.of(context).pop();
            // Navigate to stats screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatsScreen(
                  workout: widget.workout,
                  elapsedTime: _elapsed,
                  caloriesBurned: _caloriesBurnedPerMinute,
                  distanceCovered: _distanceCoveredPerMinute,
                ),
              ),
            );
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout, style: GoogleFonts.pacifico()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_run, size: 80, color: Colors.blue),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Elapsed Time',
                              style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${_elapsed.inMinutes.toString().padLeft(2, '0')}:${(_elapsed.inSeconds % 60).toString().padLeft(2, '0')}',
                              style: GoogleFonts.openSans(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: _stopwatch.isRunning ? _elapsed.inSeconds / 60.0 : 0,
                    minHeight: 10,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                        onPressed: _startStopTimer,
                        iconSize: 50,
                        color: _isRunning ? Colors.red : Colors.green,
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.stop),
                        onPressed: _resetTimer,
                        iconSize: 50,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Calories Burned: ${(double.parse((_elapsed.inSeconds * (_caloriesBurnedPerMinute / 60)).toStringAsFixed(2))).toString()}',
                    style: GoogleFonts.openSans(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Distance Covered: ${(double.parse((_elapsed.inSeconds * (_distanceCoveredPerMinute / 60)).toStringAsFixed(2))).toString()} km',
                    style: GoogleFonts.openSans(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
