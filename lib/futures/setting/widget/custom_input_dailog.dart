import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

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
        height: 300,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'تعديل القسم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'الاسم',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _image = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () {
                    print('Title: $_title');
                    print('Image URL: $_image');
                    Navigator.of(context).pop();
                  },
                  child: const Text('تعديل'),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('الغاء'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
