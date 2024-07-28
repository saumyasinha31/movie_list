import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dialog_box.dart';
import 'todo_tile.dart';
import 'data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieDatabase db = MovieDatabase();

  final _movieNameController = TextEditingController();
  final _directorController = TextEditingController();
  String? _imagePath;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (db.movieList.isEmpty) {
      db.createInitialData();
      db.updateDatabase();
    } else {
      db.loadData();
    }
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          movieNameController: _movieNameController,
          directorController: _directorController,
          onCancel: () {
            Navigator.of(context).pop();
          },
          onSave: () {
            final movie = {
              'movieName': _movieNameController.text,
              'director': _directorController.text,
              'image': _imagePath ?? '',
            };
            setState(() {
              db.movieList.add(movie);
            });
            db.updateDatabase();
            _movieNameController.clear();
            _directorController.clear();
            _imagePath = null;
            Navigator.of(context).pop();
          },
          onPickImage: pickImage,
        );
      },
    );
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void deleteMovie(int index) {
    setState(() {
      db.movieList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        elevation: 8.0,
        title: const Center(
          child: Text(
            'Movie List',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.purple[800],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.movieList.isEmpty
          ? const Center(child: Text('No movies added.'))
          : ListView.builder(
        itemCount: db.movieList.length,
        itemBuilder: (context, index) {
          final movie = db.movieList[index];
          return ToDoTile(
            deleteFunction: (context) => deleteMovie(index),
            movieName: movie['movieName'],
            director: movie['director'],
            imagePath: movie['image'],
          );
        },
      ),
    );
  }
}
