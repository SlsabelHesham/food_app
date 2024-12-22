import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/core/navigation/app_router.dart';
import 'package:food_app/core/resources/strings.dart';
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
  runApp(FoodApp(appRouter: AppRouter()));
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
