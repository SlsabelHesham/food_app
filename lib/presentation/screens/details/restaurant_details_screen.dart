import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/bloc/details/bloc/details_bloc.dart';
import 'package:food_app/domain/models/restaurant.dart';
import 'package:food_app/presentation/screens/details/restaurant_details_presenter.dart';
import 'package:food_app/presentation/widgets/detail_image_widget.dart';
import 'package:food_app/presentation/widgets/detaile_content_widget.dart';

class DetailProductScreen extends StatefulWidget {
  final Restaurant restaurant;

  const DetailProductScreen({
    super.key,
    required this.restaurant,
  });

  @override
  DetailProductScreenState createState() => DetailProductScreenState();
}

class DetailProductScreenState extends State<DetailProductScreen> {
  @override
  void initState() {
    super.initState();
    DetailScreenPresenter detailScreenPresenter =
        DetailScreenPresenter(BlocProvider.of<DetailScreenBloc>(context));
    detailScreenPresenter.fetchUserLocationAndDistance(
      restaurantLat: widget.restaurant.location.latitude,
      restaurantLon: widget.restaurant.location.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DetailImage(imagePath: widget.restaurant.image),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return DetailContent(
                scrollController: scrollController,
                restaurant: widget.restaurant,
              );
            },
          ),
        ],
      ),
    );
  }
}