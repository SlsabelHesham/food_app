import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/presentation/screens/chat/chat.dart';
import 'package:food_app/presentation/screens/home/home.dart';
import 'package:food_app/domain/bloc/home/home_bloc.dart';
import 'package:food_app/presentation/screens/home/home_presenter.dart';
import 'package:food_app/presentation/screens/profile/profile.dart';
import 'package:food_app/presentation/screens/shopping/shopping.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      Home(presenter: HomePresenter(context.read<HomeBloc>())),
      const Profile(),
      const Shopping(),
      const Chat(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        decoration: BoxDecoration(
          color: colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: GNav(
            backgroundColor: Colors.transparent,
            activeColor: const Color.fromARGB(255, 91, 174, 154),
            tabBackgroundColor: colorScheme.secondary.withOpacity(0.5),
            gap: 8,
            padding: const EdgeInsets.all(16),
            onTabChange: (index) {
              _onTabTapped(index);
            },
            tabs: [
              GButton(
                icon: Icons.home_filled,
                text: 'Home',
                textColor: colorScheme.onSecondary,
                iconColor: colorScheme.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                textColor: colorScheme.onSecondary,
                iconColor: colorScheme.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Shopping',
                textColor: colorScheme.onSecondary,
                iconColor: colorScheme.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
                textColor: colorScheme.onSecondary,
                iconColor: colorScheme.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
