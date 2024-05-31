import 'package:flutter/material.dart';

class SaveProgressWidget extends StatelessWidget {
  final Function onSave;
  final Function onCancel;

  SaveProgressWidget({required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Save Workout Progress?'),
      content: Text('Would you like to save your workout progress?'),
      actions: [
        TextButton(
          onPressed: onSave as void Function()?,
          child: Text('Save'),
        ),
        TextButton(
          onPressed: onCancel as void Function()?,
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
