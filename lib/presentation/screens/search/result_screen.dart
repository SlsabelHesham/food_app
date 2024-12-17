import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/domain/bloc/search/search_event.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';
import 'package:food_app/domain/models/menu_item.dart';
import 'package:food_app/domain/models/restaurants.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/popular_menu_widget.dart';
import 'package:food_app/presentation/widgets/restaurant_card_widget.dart';
import 'package:food_app/presentation/widgets/selected_filters.dart';

class ResultsScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const ResultsScreen({
    super.key,
    required this.data,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late List<String> foods;
  late String location;
  late String mealName;
  late String type;
  late List<String> selectedFilters;
  late List<dynamic> value;
  late final SearchBloc searchBloc;


  @override
  void initState() {
    super.initState();
    type = widget.data['type'];
    value = widget.data['restaurants'];
    foods = List<String>.from(widget.data['foods'] ?? []);
    location = widget.data['location'] ?? "";
    mealName = value.isNotEmpty ? value[0]['meal_name'] ?? "" : "";
    searchBloc = widget.data['search_block'];

    selectedFilters = [];
    if (location.isNotEmpty) selectedFilters.add(location);
    selectedFilters.addAll(foods);
  }

  void handleItemDeleted(int index) {
    setState(() {
      if (index == 0) {
        location = "";
      } else {
        foods.removeAt(index - 1);
      }
      searchBloc.add(SearchEvent(
        mealName: mealName,
        selectedType: type,
        selectedLocation: location,
        selectedFoods: foods,
      ));
      selectedFilters = [];
      if (location.isNotEmpty) selectedFilters.add(location);
      selectedFilters.addAll(foods);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            HorizontalListView(
              items: selectedFilters,
              onItemDeleted: handleItemDeleted,
            ),
            Expanded(
              child: BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (state is LoadedState) {
                    setState(() {
                      type = state.type;
                      value = state.restaurants;
                    });
                  } else if (state is ErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (value.isEmpty) {
                      return const Center(
                        child: Text(
                          "No search result",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      );
                    }

                    return type == "Meals"
                        ? _buildPopularMenu(
                            value.map((meal) {
                              return {
                                'name': meal['meal_name'] ?? "",
                                'restaurantName':
                                    meal['restaurant_name'] ?? "",
                                'image': meal['meal_image'] ?? "",
                                'price': meal['meal_price'].toString(),
                              };
                            }).toList(),
                          )
                        : _buildRestaurantListContent(
                            value.map((restaurant) {
                              return {
                                'name': restaurant['restaurant_name'] ?? "",
                                'time': restaurant['restaurant_time'] ?? "",
                                'image': restaurant['restaurant_image'] ?? "",
                              };
                            }).toList(),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantListContent(List<Map<String, dynamic>> restaurants) {
    List<Restaurant> restaurantItems = restaurants.map((restaurant) {
      return Restaurant(
        name: restaurant['name'] ?? 'Unknown',
        time: restaurant['time'] ?? 'Unknown',
        imageUrl: restaurant['image'] ?? '',
      );
    }).toList();
    return RestaurantGridContent(restaurants: restaurantItems);
  }

  Widget _buildPopularMenu(List<Map<String, dynamic>> meals) {
    List<MenuItem> menuItems = meals.map((meal) {
      return MenuItem(
        name: meal['name'] ?? 'Unknown',
        restaurantName: meal['restaurantName'] ?? 'Unknown',
        imageUrl: meal['image'] ?? '',
        price: meal['price'] ?? '0.00',
      );
    }).toList();

    return PopularMenu(meals: menuItems);
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: "Find Your \nFavorite Food",
      imageAsset: "assets/images/pattern.png",
    );
  }
}