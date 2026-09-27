import 'package:flutter/material.dart';
import '../models/shopping_item.dart';
import '../models/dish.dart';

class AppData extends ChangeNotifier {
  static final AppData instance = AppData._internal();
  AppData._internal();

  final List<ShoppingItem> shoppingList = [
    ShoppingItem(name: 'Молоко'),
    ShoppingItem(name: 'Хлеб'),
    ShoppingItem(name: 'Яйца'),
  ];

  final List<Dish> dishes = [
    Dish(
      name: 'Паста Карбонара',
      requiredIngredients: ['Спагетти', 'Яйца', 'Бекон', 'Пармезан', 'Чеснок'],
    ),
    Dish(
      name: 'Борщ',
      requiredIngredients: ['Свёкла', 'Капуста', 'Картофель', 'Морковь', 'Лук', 'Мясо'],
    ),
  ];

  void addShoppingItem(String name, ItemPriority priority) {
    if (name.trim().isEmpty) return;
    shoppingList.add(ShoppingItem(name: name.trim(), priority: priority));
    notifyListeners();
  }

  void toggleShoppingItem(int index) {
    shoppingList[index].isChecked = !shoppingList[index].isChecked;
    notifyListeners();
  }

  void removeShoppingItem(int index) {
    shoppingList.removeAt(index);
    notifyListeners();
  }

  void addDish(String name, List<String> ingredients) {
    dishes.add(Dish(name: name, requiredIngredients: ingredients));
    notifyListeners();
  }

  bool isIngredientAvailable(String ingredientName) {
    return shoppingList.any((item) =>
        item.name.toLowerCase() == ingredientName.toLowerCase() && item.isChecked);
  }

  int countAvailableIngredients(Dish dish) {
    return dish.requiredIngredients
        .where((ingredient) => isIngredientAvailable(ingredient))
        .length;
  }

  void addMissingIngredientsToShoppingList(Dish dish) {
    for (final ingredient in dish.requiredIngredients) {
      final alreadyInList = shoppingList
          .any((item) => item.name.toLowerCase() == ingredient.toLowerCase());
      if (!alreadyInList) {
        shoppingList.add(ShoppingItem(name: ingredient));
      }
    }
    notifyListeners();
  }
}