class Product {
  const Product({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.priceRub,
    required this.imageUrl,
    required this.category,
    required this.availableSizes,
    this.isNew = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final int priceRub;
  final String imageUrl;
  final String category;
  final List<String> availableSizes;
  final bool isNew;
}
