import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../models/cart_model.dart';
import '../utils/price_format.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    if (cart.isEmpty) {
      return const _EmptyCart();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 10),
          if (!cart.meetsMinOrder)
            _MinOrderBanner(
              minSumRub: CartModel.minOrderSumRub,
            ),
          if (!cart.meetsMinOrder) const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return _CartTile(item: item);
              },
            ),
          ),
          const SizedBox(height: 10),
          _SummaryBar(
            totalRub: cart.totalRub,
            enabled: cart.meetsMinOrder,
            onCheckout: cart.meetsMinOrder
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Оформление заказа (заглушка)'),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 56,
              color: Colors.black.withOpacity(0.35),
            ),
            const SizedBox(height: 10),
            Text(
              'Корзина пустая',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              'Добавьте товары из каталога',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}

class _MinOrderBanner extends StatelessWidget {
  const _MinOrderBanner({required this.minSumRub});

  final int minSumRub;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFEA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        'Минимальная сумма заказа — ${formatRub(minSumRub)} ₽',
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: const Color(0xFF9C6A52), fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _CartTile extends StatelessWidget {
  const _CartTile({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartModel>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 64,
              height: 64,
              color: const Color(0xFFF3F3F3),
              child: Image.network(
                item.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      iconSize: 18,
                      onPressed: () => cart.remove(item),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Размер: ${item.size}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black45),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${formatRub(item.product.priceRub)} ₽',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF9C6A52),
                      ),
                    ),
                    const Spacer(),
                    _QtyStepper(
                      quantity: item.quantity,
                      onMinus: () => cart.decrement(item),
                      onPlus: () => cart.increment(item),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    Widget btn(IconData icon, VoidCallback onPressed) {
      return InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFF0E3D8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF9C6A52)),
        ),
      );
    }

    return Row(
      children: [
        btn(Icons.remove_rounded, onMinus),
        const SizedBox(width: 10),
        Text(
          '$quantity',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(width: 10),
        btn(Icons.add_rounded, onPlus),
      ],
    );
  }
}

class _SummaryBar extends StatelessWidget {
  const _SummaryBar({
    required this.totalRub,
    required this.enabled,
    required this.onCheckout,
  });

  final int totalRub;
  final bool enabled;
  final VoidCallback? onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFEA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Итого',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                '${formatRub(totalRub)} ₽',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: enabled ? const Color(0xFF9C6A52) : Colors.black26,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Перейти к оформлению',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
