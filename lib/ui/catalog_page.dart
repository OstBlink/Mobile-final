import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/sample_products.dart';
import '../models/cart_model.dart';
import '../models/product.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';
import 'widgets/category_chips.dart';
import 'widgets/product_tile.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int _selectedBottomIndex = 0;
  String _selectedCategory = categories.first;

  List<Product> get _filteredProducts {
    if (_selectedCategory == 'Новинки') {
      return sampleProducts.where((p) => p.isNew).toList();
    }
    return sampleProducts.where((p) => p.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedBottomIndex,
          children: [
            _buildCatalogTab(context),
            const CartPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomIndex,
        onTap: (i) => setState(() => _selectedBottomIndex = i),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.black54,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Меню'),
          BottomNavigationBarItem(
            icon: _CartNavIcon(count: cart.totalQuantity),
            label: 'Корзина',
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          CategoryChips(
            categories: categories,
            selected: _selectedCategory,
            onSelected: (value) => setState(() => _selectedCategory = value),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredProducts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return ProductTile(
                  product: product,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CartNavIcon extends StatelessWidget {
  const _CartNavIcon({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Icon(Icons.shopping_bag_outlined),
        if (count > 0)
          Positioned(
            right: -6,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF9C6A52),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
