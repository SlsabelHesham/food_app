import 'package:flutter/material.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/domain/models/menu_item.dart';
import 'package:food_app/domain/models/restaurants.dart';
import 'package:food_app/domain/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late List<Map<String, dynamic>> nearestRestaurants;
  late List<Map<String, dynamic>> popularMenu;
  late List<Map<String, dynamic>> popularRestaurants;
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
            _buildSectionTitle(context, Strings.nearestRestaurant, "Restaurant",
                nearestRestaurants),
            _buildRestaurantListContent(nearestRestaurants),
            _buildSectionTitle(
                context, Strings.popularMenu, "Meals", popularMenu),
            _buildPopularMenu(popularMenu),
            _buildSectionTitle(context, Strings.popularRestaurant, "Restaurant",
                nearestRestaurants),
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
}
