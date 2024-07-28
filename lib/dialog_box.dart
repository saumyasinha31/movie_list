import 'package:flutter/material.dart';
import 'mybutton.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController movieNameController;
  final TextEditingController directorController;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final VoidCallback onPickImage;

  const DialogBox({
    super.key,
    required this.movieNameController,
    required this.directorController,
    required this.onCancel,
    required this.onSave,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: movieNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.pink[100],
                filled: true,
                hintText: "Movie Name",
              ),
            ),
            TextField(
              controller: directorController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.pink[100],
                filled: true,
                hintText: "Director",
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(text: "Pick Image", onPressed: onPickImage),
                const SizedBox(width: 10),
                MyButton(text: "Save", onPressed: onSave),
                const SizedBox(width: 10),
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
