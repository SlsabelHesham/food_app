import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/domain/bloc/search/search_state.dart';
import 'package:food_app/domain/models/filtered_meal.dart';
import 'package:food_app/domain/models/meal.dart';
import 'package:food_app/domain/models/restaurant.dart';
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
  late List<FilteredMeal?> value;
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
    } else if (index > 0 && location.isNotEmpty) {
      foods.removeAt(index - 1);
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
            selectedFilters.isNotEmpty
                ? HorizontalListView(
                    items: selectedFilters,
                    onItemDeleted: handleItemDeleted,
                  )
                : const SizedBox.shrink(),
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
                    } else {
                      return type == "Meals"
                          ? _buildPopularMenu(
                              value
                                  .where((meal) => meal != null)
                                  .cast<FilteredMeal>()
                                  .toList(),
                            )
                          : _buildRestaurantListContent(
                              convertFilteredMealsToRestaurants(value)
                                  .where((restaurant) => restaurant != null)
                                  .cast<Restaurant>()
                                  .toList(),
                            );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Restaurant?> convertFilteredMealsToRestaurants(
      List<FilteredMeal?> filteredMeals) {
    final List<Restaurant> restaurants = [];

    for (var meal in filteredMeals) {
      final restaurant = Restaurant(
        name: meal!.restaurantName,
        location: meal.location,
        rate: meal.restaurantRate,
        time: meal.restaurantTime,
        logo: meal.restaurantLogo,
        description: meal.restaurantDescription,
        image: meal.restaurantImage,
        meals: [
          Meal(
              name: meal.mealName,
              price: meal.mealPrice,
              image: meal.mealImage,
              rate: meal.mealRate,
              type: meal.type),
        ],
      );

      restaurants.add(restaurant);
    }

    return restaurants;
  }

  Widget _buildRestaurantListContent(List<Restaurant> restaurants) {
    return RestaurantGridContent(
      restaurants: restaurants,
      onRestaurantTap: (Restaurant selectedRestaurant) {
        Navigator.pushNamed(
          context,
          Strings.restaurantDetailsScreen,
          arguments: selectedRestaurant,
        );
      },
    );
  }

  Widget _buildPopularMenu(List<FilteredMeal> meals) {
    return PopularMenu(meals: meals);
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: Strings.headerText,
      imageAsset: Strings.headerImage,
    );
  }
}
