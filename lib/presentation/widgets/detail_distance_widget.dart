import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/domain/bloc/details/bloc/details_bloc.dart';
import 'package:food_app/domain/bloc/details/bloc/details_state.dart';

class DetailDistanceWidget extends StatelessWidget {
  const DetailDistanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailScreenBloc, DetailScreenState>(
      builder: (context, state) {
        if (state is DistanceLoadingState) {
          return const Text('Calculating distance...');
        } else if (state is DistanceLoadedState) {
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Image.asset('assets/images/borded_location.png'),
              ),
              Text(
                state.distance == -1
                    ? 'Fetching location...'
                    : '${state.distance.toStringAsFixed(2)} Km',
                style: TextStyle(
                  fontFamily: 'BentonSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.8,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          );
        } else if (state is DistanceErrorState) {
          return Text(
            'Error: ${state.error}',
            style: const TextStyle(color: Colors.red),
          );
        }
        return const SizedBox();
      },
    );
  }
}