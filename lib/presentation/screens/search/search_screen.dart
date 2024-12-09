import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/data/repositories/restaurant_repository.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/search_edit_text_widget.dart';
import 'package:food_app/presentation/widgets/choise_chip.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FilterScreen> {
  //final TextEditingController _searchController = TextEditingController();
  String selectedType = "";
  String selectedLocation = "";
  List<String> selectedFoods = [];

  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _toggleFilterChip(String label, List<String> filterList) {
    setState(() {
      if (filterList.contains(label)) {
        filterList.remove(label);
      } else {
        filterList.add(label);
      }
    });
  }
/*
  Future<void> _onSearch() async {
    String searchQuery = _searchController.text.trim();
    Query query = _firestore.collection('restaurants');

    if (searchQuery.isNotEmpty) {
      final results = await query.get();

      final List<Map<String, dynamic>> mealsList = [];

      for (final doc in results.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final mealNames = data['meal_names'] as List<dynamic>? ?? [];

        for (final meal in mealNames) {
          if (meal['name'] == searchQuery) {
            final mealIndex = meal['meal_index'] as int?;
            if (mealIndex != null &&
                mealIndex >= 0 &&
                mealIndex < (data['meals'] as List).length) {
              final fullMealData = (data['meals'] as List)[mealIndex];

              mealsList.add({
                "restaurant_name": data['name'] ?? "",
                "restaurant_image": data['image'] ?? "",
                "meal_name": fullMealData['name'] ?? "",
                "meal_price": fullMealData['price'] ?? 0.0,
                "meal_image_url": fullMealData['image'] ?? "",
                "location": data['location'] ?? {},
                "type": fullMealData['type'] ?? "",
              });
            }
          }
        }
      }

      List<Map<String, dynamic>> filteredMealsList = mealsList;

      if (selectedType.isNotEmpty) {
        if (selectedType == "Restaurant") {
          filteredMealsList = filteredMealsList
              .where((meal) => meal['restaurant_name'] != null)
              .toList();
        } else if (selectedType == "Menu") {
          filteredMealsList = filteredMealsList
              .where((meal) => meal['meal_name'] != null)
              .toList();
        }
      }

      if (selectedLocation.isNotEmpty) {
        final userLocation = await _getUserLocation();
        filteredMealsList = filteredMealsList.where((meal) {
          final restaurantLocation = meal['location'] as Map<String, dynamic>?;
          if (restaurantLocation != null) {
            final restaurantLat = restaurantLocation['latitude'] ?? 0.0;
            final restaurantLng = restaurantLocation['longitude'] ?? 0.0;
            final distance = Helper.calculateDistance(
                userLocation.latitude ?? 0.0,
                userLocation.longitude ?? 0.0,
                restaurantLat,
                restaurantLng);
            if (selectedLocation == "<10 Km") {
              return distance < 10.0;
            } else if (selectedLocation == ">10 Km") {
              return distance > 10.0;
            } else if (selectedLocation == "1 Km") {
              return distance == 1.0;
            }
          }
          return true;
        }).toList();
      }

      if (selectedFoods.isNotEmpty) {
        filteredMealsList = filteredMealsList.where((meal) {
          final mealType = meal['type']?.toString().toLowerCase();
          return mealType != null && selectedFoods.contains(mealType);
        }).toList();
      }

      if (filteredMealsList.isNotEmpty) {
        var key = "";
        if (selectedType == "Restaurant" || selectedLocation.isNotEmpty) {
          key = "Restaurant";
        } else {
          key = "Menu";
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              data: {
                "key": key,
                "value": filteredMealsList,
              },
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("لا توجد نتائج مطابقة")),
        );
      }
    }
  }
  */
/*
  Future<LocationData> _getUserLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission denied.');
      }
    }

    try {
      LocationData locationData = await location.getLocation();
      return locationData;
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }*/

  @override
  Widget build(BuildContext context) {
          print("test filter");

    return BlocProvider(
      create: (context) => FilterBloc(RepositoryProvider.of<RestaurantRepository>(context)),
      
    child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
  child: Column(
    children: [
      _buildHeader(),
            _buildHeader(),
      //Expanded(
      //test
      ///why it's happend from this 
      //
        /*child:*/ Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchEditText(context),
                const SizedBox(height: 20),
                const Text(
                  "Type",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    GenericChoiceChip(
                      label: "Restaurant",
                      isSelected: selectedType == "Restaurant",
                      onTap: () {
                        setState(() {
                          selectedType = "Restaurant";
                        });
                      },
                    ),
                    GenericChoiceChip(
                      label: "Menu",
                      isSelected: selectedType == "Menu",
                      onTap: () {
                        setState(() {
                          selectedType = "Menu";
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: [
                    GenericChoiceChip(
                      label: "1 Km",
                      isSelected: selectedLocation == "1 Km",
                      onTap: () {
                        setState(() {
                          selectedLocation = "1 Km";
                        });
                      },
                    ),
                    GenericChoiceChip(
                      label: ">10 Km",
                      isSelected: selectedLocation == ">10 Km",
                      onTap: () {
                        setState(() {
                          selectedLocation = ">10 Km";
                        });
                      },
                    ),
                    GenericChoiceChip(
                      label: "<10 Km",
                      isSelected: selectedLocation == "<10 Km",
                      onTap: () {
                        setState(() {
                          selectedLocation = "<10 Km";
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Food",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    GenericChoiceChip(
                      label: "food",
                      isSelected: selectedFoods.contains("food"),
                      onTap: () {
                        setState(() {
                          _toggleFilterChip("food", selectedFoods);
                        });
                      },
                    ),
                    GenericChoiceChip(
                      label: "soup",
                      isSelected: selectedFoods.contains("soup"),
                      onTap: () {
                        setState(() {
                          _toggleFilterChip("soup", selectedFoods);
                        });
                      },
                    ),
                    GenericChoiceChip(
                      label: "Main Course",
                      isSelected: selectedFoods.contains("Main Course"),
                      onTap: () {
                        setState(() {
                          _toggleFilterChip("Main Course", selectedFoods);
                        });
                      },
                    ),
                    GenericChoiceChip(
                      label: "Appetizer",
                      isSelected: selectedFoods.contains("Appetizer"),
                      onTap: () {
                        setState(() {
                          _toggleFilterChip("Appetizer", selectedFoods);
                        });
                      },
                    ),
                    GenericChoiceChip(
                      label: "Dessert",
                      isSelected: selectedFoods.contains("Dessert"),
                      onTap: () {
                        setState(() {
                          _toggleFilterChip("Dessert", selectedFoods);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      //),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 56, 214, 130),
            minimumSize: const Size(double.infinity, 57),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            "Search",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
),
 ),
    );
  }


/*
child: Column(
                children: [
                  BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<FilterBloc>().add(ApplyFilters());
                        },
                        child: const Text("Search"),
                      );
                    },
                  ),
                  BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      if (state is FilterLoadingState) {
                        return const CircularProgressIndicator();
                      } else if (state is FilterLoadedState) {}
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
*/
  Widget _buildSearchEditText(BuildContext context) {
    return SearchEditText(
      hintText: "What do you want to order?",
      searchIconAsset: "assets/images/icon_search.png",
      hintColor: const Color.fromARGB(255, 218, 99, 23).withOpacity(0.2),
      fillColor: const Color.fromARGB(255, 249, 168, 77).withOpacity(0.1),
      iconColor: const Color.fromARGB(255, 218, 99, 23),
      onTap: () {},
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
}
