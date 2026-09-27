import 'package:flutter/material.dart';
import 'package:nakupni_zona/screens/cards_screen.dart';
import 'dart:ui';
import 'screens/list_screen.dart';
import 'screens/food_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nakupni zona',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 226, 34, 75),
        ),
      ),
      home: const MyHomePage(title: 'Nakupní zona'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ListScreen(),
    CardsScreen(),      // "Карточки" — экран с картами лояльности
    FoodScreen(),
    ProfileScreen(),  // переименуем в "Настройки" ниже
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white.withValues(alpha: 0.7),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Список',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.credit_card),
                label: 'Карточки',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_cafe),
                label: 'Еда',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Настройки',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  


// ==== Экраны-заглушки для каждого раздела ====
// Позже наполнишь их реальным содержимым



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Профиль'));
  }
}
