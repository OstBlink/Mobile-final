import '../models/product.dart';

const categories = <String>['Новинки', 'Джинсы', 'Футболки'];

const sampleProducts = <Product>[
  Product(
    id: 'p1',
    title: 'Блейзер прямого кроя',
    subtitle: 'Двубортный блейзер на основе лиоцелла и вискозы.',
    description:
        'Универсальный блейзер прямого кроя. Мягкая посадка, лаконичный силуэт. '
        'Сочетается с базовыми образами и подходит на каждый день.',
    priceRub: 2970,
    imageUrl:
        'https://plus.unsplash.com/premium_photo-1675186049563-000f7ac02c44?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    category: 'Новинки',
    availableSizes: ['XS', 'S', 'M', 'L'],
    isNew: true,
  ),
  Product(
    id: 'p2',
    title: 'Брюки из лиоцелла',
    subtitle: 'Брюки прямого кроя из ткани.',
    description:
        'Лёгкие и приятные к телу брюки из лиоцелла. Прямой крой, аккуратная талия, '
        'хорошо держат форму.',
    priceRub: 4990,
    imageUrl:
        'https://images.unsplash.com/photo-1542272604-787c3835535d?q=80&w=1026&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    category: 'Джинсы',
    availableSizes: ['XXS', 'XS', 'S', 'M', 'L'],
  ),
  Product(
    id: 'p3',
    title: 'Кардиган из хлопка',
    subtitle: 'Короткие рукава. Застёжка на пуговицы.',
    description:
        'Кардиган из мягкого хлопка. Лёгкий, дышащий материал. '
        'Отлично для многослойных образов.',
    priceRub: 14999,
    imageUrl:
        'https://images.unsplash.com/photo-1679847628912-4c3e7402abc7?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    category: 'Новинки',
    availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
    isNew: true,
  ),
  Product(
    id: 'p4',
    title: 'Футболка basic',
    subtitle: 'Плотный хлопок. Оверсайз.',
    description:
        'Базовая футболка на каждый день. Плотный хлопок, аккуратная горловина. '
        'Сидит свободно.',
    priceRub: 1990,
    imageUrl:
        'https://images.unsplash.com/photo-1581655353564-df123a1eb820?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    category: 'Футболки',
    availableSizes: ['XS', 'S', 'M', 'L', 'XL'],
  ),
];
