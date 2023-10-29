import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  String _title = '';
  String _image = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Enter Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _image = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    // Perform any actions with the entered title and image
                    print('Title: $_title');
                    print('Image URL: $_image');
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
