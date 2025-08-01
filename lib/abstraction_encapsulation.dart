// Abstract class (Abstraction)
abstract class Vehicle {
  void startEngine(); // abstract method
  void stopEngine(); // abstract method

  void drive() {
    // print('Driving...');
  }
}

// Concrete class implementing the abstraction
class Car extends Vehicle {
  // Encapsulation: private property
  String _engineStatus = 'off';

  // Getter
  String get engineStatus => _engineStatus;

  // Setter with some validation logic
  set engineStatus(String status) {
    if (status == 'on' || status == 'off') {
      _engineStatus = status;
    } else {
      //   //print'Invalid status!');
    }
  }

  @override
  void startEngine() {
    _engineStatus = 'on';
    //print'Car engine started');
  }

  @override
  void stopEngine() {
    _engineStatus = 'off';
    //print'Car engine stopped');
  }
}

void main() {
  Car myCar = Car();

  //print'Initial engine status: ${myCar.engineStatus}');

  myCar.startEngine(); // Abstract method implementation
  //print'Engine status: ${myCar.engineStatus}');

  myCar.drive(); // Concrete method from abstract class

  myCar.engineStatus = 'invalid'; // Fails due to validation
  //print'Engine status after invalid set: ${myCar.engineStatus}');

  myCar.stopEngine();
  //print'Final engine status: ${myCar.engineStatus}');
}
