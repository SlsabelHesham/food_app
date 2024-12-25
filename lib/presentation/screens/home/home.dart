import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/models/filtered_meal.dart';
import 'package:food_app/domain/models/restaurant.dart';
import 'package:food_app/presentation/screens/home/home_presenter.dart';
import 'package:food_app/presentation/widgets/banner_widget.dart';
import 'package:food_app/presentation/widgets/header_widget.dart';
import 'package:food_app/presentation/widgets/popular_menu_widget.dart';
import 'package:food_app/presentation/widgets/restaurant_card_widget.dart';
import 'package:food_app/presentation/widgets/search_bar_widget.dart';
import 'package:food_app/presentation/widgets/section_title_widget.dart';
import 'package:food_app/styles/theme.dart';
import '../../../domain/bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late List<Restaurant> nearestRestaurants;
  late List<FilteredMeal> popularMenu;
  late List<Restaurant> popularRestaurants;
  @override
  void initState() {
    super.initState();
    HomePresenter homePresenter =
        HomePresenter(BlocProvider.of<HomeBloc>(context));
    homePresenter.loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHomeBloc());
  }

  Widget _buildHomeBloc() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildLoadingHome();
        } else if (state is HomeLoaded) {
          nearestRestaurants = state.nearestRestaurants;
          popularMenu = state.popularMenu;
          popularRestaurants = state.popularRestaurants;
          return _buildLoadedHome(context);
        } else {
          return _buildErrorHome();
        }
      },
    );
  }

  Widget _buildHeader() {
    return const HeaderWidget(
      headerText: Strings.headerText,
      imageAsset: Strings.headerImage,
    );
  }

  Widget _buildErrorHome() {
    return const Center(child: Text(""));
  }

  Widget _buildLoadingHome() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoadedHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(context),
            _buildBanner(),
            _buildSectionTitle(context, Strings.nearestRestaurant, "Restaurants",
                nearestRestaurants),
            _buildRestaurantListContent(nearestRestaurants),
            _buildSectionTitle(
              context,
              Strings.popularMenu,
              "Meals",
              popularMenu,
            ),
            _buildPopularMenu(popularMenu),
            _buildSectionTitle(context, Strings.popularRestaurant, "Restaurants",
                popularRestaurants),
            _buildRestaurantListContent(popularRestaurants),
            const SizedBox(height: 110)
          ],
        ),
      ),
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

  Widget _buildSectionTitle(
      BuildContext context, String title, String type, List<dynamic> list) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 16.0),
      child: SectionTitle(
        title: title,
        onViewMore: () {
          Navigator.pushNamed(
            context,
            Strings.viewMoreScreen,
            arguments: {'type': type, 'items': list},
          );
        },
      ),
    );
  }

  Widget _buildRestaurantListContent(List<Restaurant> restaurants) {
    return RestaurantListContent(
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
    List<FilteredMeal> viewedMeals = [];
    if (meals.length > 2) {
      viewedMeals.add(meals[0]);
      viewedMeals.add(meals[1]);
    } else {
      viewedMeals = meals;
    }
    return PopularMenu(meals: viewedMeals);
  }
}
