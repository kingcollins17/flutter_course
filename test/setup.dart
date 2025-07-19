import 'dart:io';

import 'package:flutter_course/models/guess_model.dart';
import 'package:hive/hive.dart';

Future setup() async {
  var path = Directory.current.path; // or a custom test path
  Hive.init(path);
  Hive.registerAdapter(GuessModelAdapter());
  await Hive.openBox('guesses');
}
