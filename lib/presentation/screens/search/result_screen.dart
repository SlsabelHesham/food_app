import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';
import 'package:food_app/domain/models/menu_item.dart';
import 'package:food_app/domain/models/restaurants.dart';
import 'package:food_app/presentation/screens/search/search_presenter.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/popular_menu_widget.dart';
import 'package:food_app/presentation/widgets/restaurant_card_widget.dart';
import 'package:food_app/presentation/widgets/selected_filters.dart';
import 'package:food_app/styles/text_styles.dart';

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
  late SearchPresenter searchPresenter;

  @override
  void initState() {
    super.initState();
    type = widget.data[Strings.type];
    value = widget.data[Strings.restaurants];
    foods = List<String>.from(widget.data[Strings.foods] ?? []);
    location = widget.data[Strings.location] ?? "";
    mealName = widget.data[Strings.mealName];
    searchPresenter = SearchPresenter(BlocProvider.of<SearchBloc>(context));

    selectedFilters = [];
    if (location.isNotEmpty) selectedFilters.add(location);
    selectedFilters.addAll(foods);
  }

  void handleItemDeleted(int index) {
    if (index == 0 && location.isNotEmpty) {
      location = "";
    } else {
      foods.removeAt(index);
    }
    searchPresenter.search(
      mealName,
      type,
      location,
      foods,
    );
    selectedFilters = [];
    if (location.isNotEmpty) selectedFilters.add(location);
    selectedFilters.addAll(foods);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            selectedFilters.isNotEmpty ?
            HorizontalListView(
              items: selectedFilters,
              onItemDeleted: handleItemDeleted,
            ): const SizedBox.shrink(),
            Expanded(
              child: BlocListener<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (state is SearchLoaded) {
                    setState(() {
                      type = state.type;
                      value = state.restaurants;
                    });
                  } else if (state is SearchError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (value.isEmpty) {
                      return Center(
                        child: Text(
                          Strings.noSearchResult,
                          style: TextStyles.mainTitle(),
                        ),
                      );
                    }

                    return type == "Meals"
                        ? _buildPopularMenu(
                            value.map((meal) {
                              return {
                                'name': meal['meal_name'] ?? "",
                                'restaurantName': meal['restaurant_name'] ?? "",
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
      headerText: Strings.headerText,
      imageAsset: Strings.headerImage,
    );
  }
}
