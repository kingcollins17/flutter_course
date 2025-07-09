class CartController {
  List<String> carts = [];

  void updateCart() {
    carts.addAll(List.generate(4, (i) => 'Cart item ${i + 1}'));
  }
}

class AuthController {
  static const correctEmail = 'collinsxnnanna@gmail.com';
  static const correctPassword = 'Password123';

  String? accessToken;

  List<String> products = [];

  bool get isLoggedIn => accessToken != null;

  void sign(String email, String password) {
    if (email == correctEmail && password == correctPassword) {
      accessToken = 'TEST_ACCESS_TOKEN';
    }
    return;
  }

  void fetchProducts() {
    products.addAll(List.filled(5, 'Product'));
  }
}
