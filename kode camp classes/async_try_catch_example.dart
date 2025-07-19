// import 'dart:async';

// // ignore_for_file: avoid_print

// void main() async {
//   // Entry point of the application.
//   // We're calling a wrapper function that handles a future and its errors.
//   await wrapFuture1();
// }

// Future<String> future1() async {
//   await Future.delayed(Duration(seconds: 3)); // Simulate delay
//   throw 'Future 1 Error'; // Simulate an error occurring in the future
//   // return 'Future 1 Result'; // Simulate a successful result
// }

// Future<String> wrapFuture1() async {
//   try {
//     // Await the result of future1
//     final result = await future1();
//     log('Result: future1(): result=<$result>'); // Log the result
//     return result; // Return the result back to the caller
//   } catch (e) {
//     // Handle any errors thrown by future1
//     log('Error: wrapFuture1(): error=<$e>');
//     rethrow; // Propagate the error up the call stack
//   }
//   // Uncomment the block below to always log when the future completes, regardless of success or error
//   finally {
//     log('Finally: wrapFuture1(): ...');
//   }
// }

// void log(value) {
//   print('$value');
// }
