
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/search_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/history_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const TransportApp());
}

const Color primaryBlue = Color(0xFF2563EB);
const Color backgroundColor = Color(0xFFF5F7FC);

class TransportApp extends StatelessWidget {
  const TransportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transport App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
        ),
        fontFamily: 'Roboto',
      ),
      home: const AppStart(),
    );
  }
}

// GESTION DU DEMARRAGE

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (currentPage == 0) {
      return SplashScreen(
        onFinished: () {
          setState(() {
            currentPage = 1;
          });
        },
      );
    }

    if (currentPage == 1) {
      return LoginScreen(
        onLoginSuccess: () {
          setState(() {
            currentPage = 2;
          });
        },
      );
    }

    return const MainScreen();
  }
}

// NAVIGATION PRINCIPALE

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  late final List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: primaryBlue.withOpacity(0.12),

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home,
              color: primaryBlue,
            ),
            label: 'Accueil',
          ),

          NavigationDestination(
            icon: Icon(Icons.directions_transit_outlined),
            selectedIcon: Icon(
              Icons.directions_transit,
              color: primaryBlue,
            ),
            label: 'Trajets',
          ),

          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(
              Icons.favorite,
              color: primaryBlue,
            ),
            label: 'Favoris',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(
              Icons.person,
              color: primaryBlue,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
