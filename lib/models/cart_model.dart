import 'package:flutter/foundation.dart';

import 'cart_item.dart';
import 'product.dart';

class CartModel extends ChangeNotifier {
  static const int minOrderSumRub = 10000;

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalQuantity => _items.fold(0, (sum, e) => sum + e.quantity);

  int get totalRub => _items.fold(0, (sum, e) => sum + e.lineTotalRub);

  bool get isEmpty => _items.isEmpty;

  bool get meetsMinOrder => totalRub >= minOrderSumRub;

  void add(Product product, {required String size}) {
    final idx = _items.indexWhere((e) => e.product.id == product.id && e.size == size);
    if (idx >= 0) {
      _items[idx].quantity += 1;
    } else {
      _items.add(CartItem(product: product, size: size, quantity: 1));
    }
    notifyListeners();
  }

  void increment(CartItem item) {
    final idx = _items.indexWhere((e) => e.key == item.key);
    if (idx < 0) return;
    _items[idx].quantity += 1;
    notifyListeners();
  }

  void decrement(CartItem item) {
    final idx = _items.indexWhere((e) => e.key == item.key);
    if (idx < 0) return;

    final current = _items[idx];
    if (current.quantity <= 1) {
      _items.removeAt(idx);
    } else {
      current.quantity -= 1;
    }
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.removeWhere((e) => e.key == item.key);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
