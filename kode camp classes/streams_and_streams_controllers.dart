// ignore_for_file: avoid_print

import 'dart:async';

Stream<int> timedCounter() {
  return Stream.periodic(Duration(seconds: 1), (count) => count).take(5);
}

Stream<String> getMessages() async* {
  for (var i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    if (i == 3) throw 'I is equal to 3';
    yield 'From external stream: value $i';
  }
}

Stream<String> getMessages1() async* {
  for (var i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    if (i == 3) throw 'I is equal to 3';
    yield 'From external stream: value $i';
  }
}

Stream<String> getMessage2() async* {
  for (var i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    if (i == 3) throw 'I is equal to 3';
    yield 'From external stream: value $i';
  }
}

void main() async {
  final controller = StreamController<String>();
  // Stream<String> stream = controller.stream;

  controller.stream.listen(
    (data) => print('from listener 1 $data'),
    onError: (err) {
      print(err);
      print(err.runtimeType);
    },
  );
  await Future.delayed(Duration(seconds: 1));

  controller.stream.listen(
    (data) => print('from listener 2 $data'),
    onError: (err) {
      print(err);
      print(err.runtimeType);
    },
  );

  for (var i = 0; i < 5; i++) {
    controller.add('Stream value ${i + 1}');
  }
}

// void main() async {
//   // === 1. Creating a simple single-subscription stream ===
//   Stream<int> simpleStream = Stream.fromIterable([1, 2, 3, 4, 5]);

//   print('--- Listening to simpleStream ---');
//   simpleStream.listen(
//     (data) => print('simpleStream data: $data'),
//     onError: (err) => print('simpleStream error: $err'),
//     onDone: () => print('simpleStream done'),
//   );

//   // === 2. Mapping values in a stream ===
//   Stream<String> mappedStream = simpleStream.map((number) => 'Number: $number');

//   print('\n--- Listening to mappedStream ---');
//   mappedStream.listen((data) => print('mappedStream data: $data'));

//   // === 3. Creating a broadcast stream ===
//   Stream<int> broadcastStream = simpleStream.asBroadcastStream();

//   print('\n--- Listening to broadcastStream on multiple listeners ---');
//   broadcastStream.listen((data) => print('Listener 1: $data'));
//   broadcastStream.listen((data) => print('Listener 2: $data'));

//   // === 4. Using a StreamController ===
//   StreamController<String> controller = StreamController<String>();

//   // Add listener
//   controller.stream.listen(
//     (data) => print('\ncontroller stream data: $data'),
//     onError: (err) => print('controller stream error: $err'),
//     onDone: () => print('controller stream done'),
//   );

//   // Add data and error
//   controller.sink.add('Hello from controller');
//   controller.sink.add('Another event');
//   controller.sink.addError('Something went wrong');
//   controller.sink.add('More data');
//   controller.close();

//   // === 5. Using a broadcast StreamController ===
//   StreamController<String> broadcastController =
//       StreamController<String>.broadcast();

//   broadcastController.stream.listen(
//     (data) => print('\nBroadcast Listener 1: $data'),
//   );
//   broadcastController.stream.listen(
//     (data) => print('Broadcast Listener 2: $data'),
//   );

//   broadcastController.sink.add('Hello from broadcast controller');
//   broadcastController.sink.add('Another broadcast event');
//   broadcastController.close();
// }
