import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import 'cart_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        actions: [
          IconButton(
            tooltip: 'Очистить',
            onPressed: cart.isEmpty
                ? null
                : () {
                    context.read<CartModel>().clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Корзина очищена')),
                    );
                  },
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: const SafeArea(child: CartPage()),
    );
  }
}
