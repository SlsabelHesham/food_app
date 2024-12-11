import 'package:flutter/material.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';

class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResultsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final String key = data['type'];
    final List<dynamic> value = data['restaurants'];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 247, 254),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (value.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    "لا توجد نتائج",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              Expanded(
                child: key == "Meals"
                    ? ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final meal = value[index];
                          return _buildMenuCard(
                            meal['meal_name'] ?? "وجبة غير معروفة",
                            meal['restaurant_name'] ?? "مطعم غير معروف",
                            meal['meal_image'] ?? "",
                            meal['meal_price'].toString(),
                          );
                        },
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          crossAxisSpacing: 10, 
                          mainAxisSpacing: 10, 
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final restaurant = value[index];
                          return _buildRestaurantCard(
                            restaurant['restaurant_name'] ?? "مطعم غير معروف",
                            restaurant['time'] ?? "",
                            restaurant['restaurant_image'] ?? "",
                            context,
                          );
                        },
                      ),
              ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildMenuCard(
      String name, String restaurantName, String imageUrl, String price) {
        print("dataaaaa ${name} ${restaurantName} ${imageUrl} ${price}");
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 87,
        child: Row(
          children: [
            if (imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageUrl,
                  height: 64,
                  width: 64,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurantName,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    price,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
Widget _buildHeader() {
  return const HeaderWidget(
    headerText: "Find Your \nFavorite Food",
    imageAsset: "assets/images/pattern.png",
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
}
  Widget _buildRestaurantCard(
      String name, String time, String imageUrl, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 21, left: 21, top: 26),
            child: Image.network(
              imageUrl,
              height: 73,
              width: 96,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25, left: 25, top: 17),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 26),
            child: Text(
              time,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
