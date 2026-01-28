import 'product.dart';

class CartItem {
  CartItem({
    required this.product,
    required this.size,
    this.quantity = 1,
  });

  final Product product;
  final String size;
  int quantity;

  String get key => '${product.id}::$size';

  int get lineTotalRub => product.priceRub * quantity;
}
