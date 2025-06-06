import 'dart:async';

// ignore_for_file: avoid_print
Future<String> myFuture(Completer<String> completer) async {
  await Future.delayed(Duration(seconds: 3));
  return completer.future;
}

// Future<String> wrapFuture() async {
//   try {
//     final result = await myFuture(myCompleter);
//     return result;
//     // myCompleter.complete();
//   } catch (e) {
//     flutterLog(e.toString());
//   }
// }

void flutterLog(value) {
  ///
  print('$value');
}
