// import 'dart:async';

// // ignore_for_file: avoid_print

// void main() async {
//   // Entry point of the application.
//   // We're calling a wrapper function that handles a future and its errors.
//   await wrapFuture1();
// }

// /// Simulates a long-running asynchronous operation.
// ///
// /// This function waits for 3 seconds, then throws an error.
// /// Uncomment the return line to simulate a successful future instead.
// ///
// /// Returns a [Future] that either completes with a [String] or throws an error.
// Future<String> future1() async {
//   await Future.delayed(Duration(seconds: 3)); // Simulate delay
//   throw 'Future 1 Error'; // Simulate an error occurring in the future
//   // return 'Future 1 Result'; // Simulate a successful result
// }

// /// Wraps [future1] with error handling logic.
// ///
// /// This function awaits the result of [future1], catches any errors that occur,
// /// logs the result or error, and rethrows the error so it can be handled further up if needed.
// ///
// /// Returns a [Future] that completes with the result of [future1] if successful.
// /// If an error is thrown, it is caught, logged, and rethrown.
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
//   // finally {
//   //   log('Finally: wrapFuture1(): ...');
//   // }
// }

// /// A simple logger utility to print messages to the console.
// ///
// /// This helps standardize how messages are logged.
// ///
// /// [value] is the object or message to be logged.
// void log(value) {
//   print('$value');
// }
