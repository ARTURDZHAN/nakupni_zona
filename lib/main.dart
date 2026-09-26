import 'package:flutter/material.dart';
import 'dart:ui';
import 'screens/home_screen.dart';
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
          seedColor: const Color.fromARGB(255, 52, 161, 143),
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
  int _selectedIndex = 0; // какая вкладка выбрана сейчас

  // Список экранов — каждый соответствует своей кнопке
  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    ListScreen(),
    CardsScreen(),
    FoodScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // обновляем выбранную вкладку
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // важно! контент будет заходить под панель
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _pages[_selectedIndex], // показываем текущий раздел
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20), // сила размытия
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white.withValues(alpha: 0.7), // полупрозрачный фон
            elevation: 0, // убираем стандартную тень
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Главная',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Список',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: 'Карточки',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Еда',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Профиль',
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

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Карты'));
  }
}

  


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Профиль'));
  }
}