import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart_model.dart';
import 'ui/catalog_page.dart';

void main() {
  runApp(const ShopUiApp());
}

class ShopUiApp extends StatelessWidget {
  const ShopUiApp({super.key});

  static const _brandBrown = Color(0xFF9C6A52);

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _brandBrown,
      brightness: Brightness.light,
    );

    return ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop UI',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            bodyMedium: TextStyle(fontSize: 14, height: 1.35),
            bodySmall: TextStyle(fontSize: 12, height: 1.35),
          ),
        ),
        home: const CatalogPage(),
      ),
    );
  }
}
