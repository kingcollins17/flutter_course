// ignore_for_file: avoid_print

// import 'dart:async';

// import 'async_try_catch_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/Random_Game/home.dart';
import 'package:flutter_course/bindings/app_bindings.dart';
import 'package:get/get.dart';


void main() {
  MyBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //initialBinding: MyBindings(),
      home: Home(),
    );
  }
}

