import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'mybutton.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController movieNameController;
  final TextEditingController directorController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.movieNameController,
    required this.directorController,
    required this.onCancel,
    required this.onSave,
  });

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: widget.movieNameController,
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
              controller: widget.directorController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.pink[100],
                filled: true,
                hintText: "Director",
              ),
            ),
            _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(text: "Save", onPressed: () {
                  widget.onSave();
                  Navigator.pop(context, _image);
                }),
                const SizedBox(width: 10),
                MyButton(text: "Cancel", onPressed: widget.onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
