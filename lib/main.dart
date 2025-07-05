import 'package:flutter/material.dart';
import 'package:flutter_course/binding.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/guess_model.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GuessModelAdapter());
  await Hive.openBox('guesses');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '4-Word Guess Game',
      home: HomeScreen(),
      initialBinding: GameBinding(),
    );
  }
}
