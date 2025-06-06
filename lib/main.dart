// import 'package:flutter/material.dart';
// ignore_for_file: avoid_print

import 'dart:async';

import 'async_example.dart';

void main() async {
  try {
    final myCompleter = Completer<String>();
    print('starting main():');
    Future.delayed(Duration(seconds: 4), () {
      print('Completing with Completer');
      myCompleter.complete('Completed result');
    });
    final result = await myFuture(myCompleter);
    print('future resolved with result: main(): $result');
  } catch (e) {
    print('Caught error in main(): $e');
  } finally {
    print('Running finally block in main():');
  }
}

// class FLutterCourseApp extends StatelessWidget {
//   const FLutterCourseApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
