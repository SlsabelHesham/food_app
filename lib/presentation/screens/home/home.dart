import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
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
import 'package:food_app/styles/theme.dart';
import '../../../domain/bloc/home/home_bloc.dart';

class Home extends StatelessWidget {
  final HomePresenter presenter;

  const Home({super.key, required this.presenter});
  @override
  Widget build(BuildContext context) {
    presenter.loadHomeData();
    return Scaffold(
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
                    _buildSectionTitle(context, Strings.nearestRestaurant,
                        "Restaurant", state.nearestRestaurants),
                    _buildRestaurantListContent(state.nearestRestaurants),
                    _buildSectionTitle(
                        context, Strings.popularMenu, "Meals", state.popularMenu),
                    _buildPopularMenu(state.popularMenu),
                    _buildSectionTitle(context, Strings.popularRestaurant,
                        "Restaurant", state.nearestRestaurants),
                    _buildRestaurantListContent(state.popularRestaurants),
                    const Padding(padding: EdgeInsets.only(bottom: 20))
                  ],
                ),
              );
            } else {
              return const Center(child: Text(""));
            }
          },
        ),
      ),
    );
  }
}

Widget _buildHeader() {
    return const HeaderWidget(
      headerText: Strings.headerText,
      imageAsset: Strings.headerImage,
    );
  }

Widget _buildSearchBar(BuildContext context) {
  return SearchBarWidget(
    context: context,
    searchHintText: "",
    filterImageAsset: AppTheme.getFilterIconAsset(context),
  );
}

Widget _buildBanner() {
  return const BannerWidget(
    imageAsset: Strings.bannerImage,
  );
}

Widget _buildSectionTitle(BuildContext context, String title, String type,
    List<Map<String, dynamic>> list) {
  return SectionTitle(
    title: title,
    onViewMore: () {
      Navigator.pushNamed(
        context,
        Strings.viewMoreScreen,
        arguments: {'type': type, 'items': list},
      );
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
  List<MenuItem> menuItems = meals.take(2).map((meal) {
    return MenuItem(
      name: meal['name'] ?? 'Unknown',
      restaurantName: meal['restaurantName'] ?? 'Unknown',
      imageUrl: meal['image'] ?? '',
      price: meal['price'] ?? '0.00',
    );
  }).toList();

  return PopularMenu(meals: menuItems);
}
