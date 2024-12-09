import 'package:flutter/material.dart';
import 'package:food_app/domain/models/menu_item.dart';
import 'package:food_app/domain/models/restaurants.dart';
import 'package:food_app/presentation/screens/home/home_presenter.dart';
import 'package:food_app/domain/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/widgets/banner_widget.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/popular_menu_widget.dart';
import 'package:food_app/presentation/widgets/restaurant_card_widget.dart';
import 'package:food_app/presentation/widgets/search_bar_widget.dart';
import 'package:food_app/presentation/widgets/section_title_widget.dart';
import '../../../domain/bloc/home/home_bloc.dart';

class Home extends StatelessWidget {
  final HomePresenter presenter;

  const Home({super.key, required this.presenter});
  @override
  Widget build(BuildContext context) {
    presenter.loadHomeData();
          print("test filter hh");

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 247, 254),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildSearchBar(context),
                    _buildBanner(),
                    _buildSectionTitle("Nearest Restaurant"),
                    _buildRestaurantListContent(state.nearestRestaurants),
                    _buildSectionTitle("Popular Menu"),
                    _buildPopularMenu(state.popularMenu),
                    _buildSectionTitle("Popular Restaurant"),
                    _buildRestaurantListContent(state.popularRestaurants),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Error loading data."));
            }
          },
        ),
      ),
    );
  }
}

Widget _buildHeader() {
  return const HeaderWidget(
    headerText: "Find Your \nFavorite Food",
    imageAsset: "assets/images/pattern.png",
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
}

Widget _buildSearchBar(BuildContext context) {
 return SearchBarWidget(
    context: context,
    searchHintText: "",
    filterImageAsset: "assets/images/filter.png",
  );
}

Widget _buildBanner() {
  return const BannerWidget(
    imageAsset: "assets/images/promo_advertising.png",
  );
}

Widget _buildSectionTitle(String title) {
  return SectionTitle(
    title: title, 
    onViewMore: () {
    },
  );
}

Widget _buildRestaurantListContent(List<Map<String, dynamic>> restaurants) {
  List<Restaurant> restaurantsItems = restaurants.map((restaurant) {
    return Restaurant(
      name: restaurant['name'] ?? 'Unknown',
      time: restaurant['time'] ?? 'Unknown',
      imageUrl: restaurant['image'] ?? '',
    );
  }).toList();
  return RestaurantListContent(restaurants: restaurantsItems);
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
