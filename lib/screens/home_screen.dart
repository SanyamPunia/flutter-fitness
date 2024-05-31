import 'package:flutter/material.dart';
import 'workout_screen.dart';
import 'add_workout_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker', style: GoogleFonts.pacifico()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Image.asset(
                'assets/running.png',
                width: 36,
                height: 36,
              ),
              title: Text('Running', style: GoogleFonts.openSans(fontSize: 18)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutScreen(workout: 'Running')),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset(
                'assets/cycling.png',
                width: 36,
                height: 36,
              ),
              title: Text('Cycling', style: GoogleFonts.openSans(fontSize: 18)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutScreen(workout: 'Cycling')),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add, size: 36, color: Colors.grey),
              title: Text('Add Workout', style: GoogleFonts.openSans(fontSize: 18)),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWorkoutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
