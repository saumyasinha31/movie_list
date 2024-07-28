import 'package:hive_flutter/hive_flutter.dart';

class MovieDatabase {
  List<Map<String, dynamic>> movieList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    movieList = [
      {
        'movieName': "Inception",
        'director': "Christopher Nolan",
        'image': '', // Placeholder for image path
      },
      {
        'movieName': "Interstellar",
        'director': "Christopher Nolan",
        'image': '', // Placeholder for image path
      },
    ];
  }

  void loadData() {
    movieList = List<Map<String, dynamic>>.from(_myBox.get('MOVIELIST', defaultValue: []));
  }

  void updateDatabase() {
    _myBox.put('MOVIELIST', movieList);
  }
}
