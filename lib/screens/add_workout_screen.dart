import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddWorkoutScreen extends StatefulWidget {
  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _nameController = TextEditingController();
  String? _selectedIcon;

  void _addWorkout() {
    // Logic to add workout (for now, just a placeholder)
    final name = _nameController.text;
    if (name.isNotEmpty && _selectedIcon != null) {
      // Add the workout
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a name and select an icon')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Workout', style: GoogleFonts.pacifico()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Workout Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text('Select Icon', style: GoogleFonts.openSans(fontSize: 18)),
            Wrap(
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _selectedIcon = 'assets/running.png'),
                  child: Image.asset(
                    'assets/running.png',
                    width: 50,
                    height: 50,
                    color: _selectedIcon == 'assets/running.png' ? Colors.blue : null,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _selectedIcon = 'assets/cycling.png'),
                  child: Image.asset(
                    'assets/cycling.png',
                    width: 50,
                    height: 50,
                    color: _selectedIcon == 'assets/cycling.png' ? Colors.green : null,
                  ),
                ),
                // Add more icons here
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _addWorkout,
              child: Text('Add Workout'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
