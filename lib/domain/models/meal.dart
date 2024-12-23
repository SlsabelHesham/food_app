class Meal {
  final String name;
  final String image;
  final String price;
  final double rate;
  final String type;
  Meal({
    required this.name,
    required this.image,
    required this.price,
    required this.rate,
    required this.type,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      name: map['name'] ?? 'Unknown Meal',
      image: map['image'],
      price: (map['price']),
      rate: (map['rate'] as num).toDouble(),
      type: map['type'],
    );
  }
}