import 'dart:async';

// ignore_for_file: avoid_print

void main() async {
  // Entry point
  await wrapFuture1();
}

/// Simulates an asynchronous task using a [Completer].
///
/// This function creates a completer and completes it after a delay,
/// either with a result or with an error to demonstrate both success and failure scenarios.
///
/// Returns a [Future<String>] that either completes with data or throws an error.
Future<String> future1() {
  final completer = Completer<String>();

  // Simulate async work with a delay
  Future.delayed(Duration(seconds: 3), () {
    // Uncomment to simulate success:
    // completer.complete('Future 1 Result');

    // Simulate an error:
    completer.completeError('Future 1 Error');
  });

  return completer.future;
}

/// Wraps [future1] with error handling logic using try-catch.
///
/// This function awaits the result from [future1], logs the output or error,
/// and rethrows the error to demonstrate propagation of exceptions.
Future<String> wrapFuture1() async {
  try {
    final result = await future1();
    log('Result: future1(): result=<$result>');
    return result;
  } catch (e) {
    log('Error: wrapFuture1(): error=<$e>');
    rethrow;
  }
  // finally {
  //   log('Finally: wrapFuture1(): This runs whether it succeeds or fails.');
  // }
}

/// A simple logger utility for printing messages.
void log(value) {
  print('$value');
}
