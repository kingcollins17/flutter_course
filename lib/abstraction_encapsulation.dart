// class Certificate {}

// abstract interface class Repository {
//   List<Certificate> getCerticates();

//   void save(Certificate value);
// }

// class CloudRepository implements Repository {
//   @override
//   List<Certificate> getCerticates() {
//     return [];
//   }

//   @override
//   void save(Certificate value) {
//     print('Saved certificate to cloud');
//   }
// }

// class LocalStorageRepository implements Repository {
//   @override
//   List<Certificate> getCerticates() {
//     return [];
//   }

//   @override
//   void save(Certificate value) {
//     print('Saved cerficate to users device');
//   }
// }

// // Abstract class (Abstraction)
// abstract class Vehicle {
//   void startEngine() {} // abstract method
//   void stopEngine() {} // abstract method

//   void drive() {}
// }

// // Concrete class implementing the abstraction
// // class Car extends Vehicle {
// //   // // Encapsulation: private property
// //   String _engineStatus = 'off';

// //   int _count = 0;

// //   // Getter
// //   String get engineStatus => _engineStatus;

// //   // Setter with some validation logic
// //   set engineStatus(String status) {
// //     if (status == 'on' || status == 'off') {
// //       _engineStatus = status;
// //     } else {
// //       print('Invalid status!');
// //     }
// //   }

// //   @override
// //   void startEngine() {
// //     _engineStatus = 'on';
// //     print('Car engine started');
// //   }

// //   @override
// //   void stopEngine() {
// //     _engineStatus = 'off';
// //     print('Car engine stopped');
// //   }

// //   @override
// //   void drive() {}
// // }

// Repository injectCloudRepo() {
//   return CloudRepository();
// }

// Repository injectLocalRepo() {
//   return LocalStorageRepository();
// }

// void main() {
//   final Repository repo = injectCloudRepo();

//   repo.getCerticates();
//   repo.save(Certificate());

//   // Car myCar = Car();

//   // print('Initial engine status: ${myCar.engineStatus}');

//   // myCar.startEngine(); // Abstract method implementation
//   // print('Engine status: ${myCar.engineStatus}');

//   // myCar.drive(); // Concrete method from abstract class

//   // myCar.engineStatus = 'invalid'; // Fails due to validation
//   // print('Engine status after invalid set: ${myCar.engineStatus}');

//   // myCar.stopEngine();
//   // print('Final engine status: ${myCar.engineStatus}');
// }
