import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/navigation/app_router.dart';
import 'package:food_app/core/resources/strings.dart';
import 'package:food_app/data/datasources/remote_datasource/restaurant_datasource_impl.dart';
import 'package:food_app/data/repositories/restaurant_repository_impl.dart';
import 'package:food_app/domain/bloc/home/home_bloc.dart';
import 'package:food_app/domain/bloc/search/search_bloc.dart';
import 'package:food_app/presentation/screens/search/search_presenter.dart';
import 'package:food_app/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: "Food App",
      options: const FirebaseOptions(
        apiKey: Strings.apiKey,
        appId: Strings.appId,
        messagingSenderId: Strings.messagingSenderId,
        projectId: Strings.projectId,
        storageBucket: Strings.storageBucket,
      ),
    );
  }
  final restaurantDataSource = RestaurantDataSourceImpl(FirebaseFirestore.instance);
  final restaurantRepository = RestaurantRepositoryImpl(restaurantDataSource);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                HomeBloc(restaurantRepository)),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(RestaurantPresenter(restaurantDataSource)),
        ),
      ],
      child: FoodApp(appRouter: AppRouter()),
    ),
  );
}

class FoodApp extends StatelessWidget {
  final AppRouter appRouter;

  const FoodApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      theme: AppTheme.lightTheme, 
      darkTheme: AppTheme.darkTheme, 
      themeMode: ThemeMode.system,
    );
  }
}
