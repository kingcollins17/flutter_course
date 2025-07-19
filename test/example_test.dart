// import 'package:flutter_course/controllers.dart';
// import 'package:test/test.dart';

// void main() {
//   late AuthController controller;

//   setUpAll(() {
//     controller = AuthController();
//   });

//   group('CartController', () {
//     test('Test updateController works', () {
//       final controller = CartController();
//       controller.updateCart();
//       expect(controller.carts, isNotEmpty);
//     });
//   });

//   group('AuthController', () {
//     test(
//       'Test AuthController.fetchProducts populates the products database',
//       () {
//         controller.fetchProducts();

//         expect(controller.products, isNotEmpty);
//       },
//     );
//     test('Test AuthController.signIn fails with incorrect password', () {
//       controller.sign('ngozie@gmail.com', 'WrongPassword');

//       expect(controller.isLoggedIn, equals(false));
//     });

//     test('Test AuthController.signIn passes with correct password', () {
//       controller.sign('collinsxnnanna@gmail.com', 'Password123');

//       expect(controller.isLoggedIn, equals(true));
//     });
//   });
// }
