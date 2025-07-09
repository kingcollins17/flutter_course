import 'package:test/test.dart';

class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
  double divide(int a, int b) {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    return a / b;
  }
}

class ShoppingCart {
  final List<String> _items = [];

  void addItem(String item) {
    _items.add(item);
  }

  void removeItem(String item) {
    _items.remove(item);
  }

  int get itemCount => _items.length;

  List<String> get items => List.unmodifiable(_items);

  void clear() {
    _items.clear();
  }
}

void main() {
  group('Calculator Tests', () {
    late Calculator calculator;

    setUp(() {
      calculator = Calculator();
    });

    test('should add two numbers correctly', () {
      expect(calculator.add(2, 3), equals(5));
      expect(calculator.add(-1, 1), equals(0));
      expect(calculator.add(0, 0), equals(0));
    });

    test('should subtract two numbers correctly', () {
      expect(calculator.subtract(5, 3), equals(2));
      expect(calculator.subtract(1, 1), equals(0));
      expect(calculator.subtract(0, 5), equals(-5));
    });

    test('should divide two numbers correctly', () {
      expect(calculator.divide(10, 2), equals(5.0));
      expect(calculator.divide(7, 2), equals(3.5));
    });

    test('should throw error when dividing by zero', () {
      expect(() => calculator.divide(10, 0), throwsArgumentError);
    });
  });

  group('Shopping Cart Tests', () {
    late ShoppingCart cart;

    setUp(() {
      cart = ShoppingCart();
    });

    test('should start with empty cart', () {
      expect(cart.itemCount, equals(0));
      expect(cart.items, isEmpty);
    });

    test('should add items to cart', () {
      cart.addItem('Apple');
      cart.addItem('Banana');

      expect(cart.itemCount, equals(2));
      expect(cart.items, contains('Apple'));
      expect(cart.items, contains('Banana'));
    });

    test('should remove items from cart', () {
      cart.addItem('Apple');
      cart.addItem('Banana');
      cart.removeItem('Apple');

      expect(cart.itemCount, equals(1));
      expect(cart.items, contains('Banana'));
      expect(cart.items, isNot(contains('Apple')));
    });

    test('should clear all items from cart', () {
      cart.addItem('Apple');
      cart.addItem('Banana');
      cart.clear();

      expect(cart.itemCount, equals(0));
      expect(cart.items, isEmpty);
    });
  });
}
