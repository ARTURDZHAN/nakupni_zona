import 'package:flutter/material.dart';
import '../../models/shopping_item.dart';
import '../../models/dish.dart';

class AppData extends ChangeNotifier {
  // Singleton — единственный экземпляр на всё приложение
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

  // ==== Методы для работы со списком покупок ====

  void addShoppingItem(String name) {
    if (name.trim().isEmpty) return;
    shoppingList.add(ShoppingItem(name: name.trim()));
    notifyListeners(); // сообщаем всем экранам: "данные изменились, перерисуйтесь"
  }

  void toggleShoppingItem(int index) {
    shoppingList[index].isChecked = !shoppingList[index].isChecked;
    notifyListeners();
  }

  void removeShoppingItem(int index) {
    shoppingList.removeAt(index);
    notifyListeners();
  }

  // ==== Методы для работы с блюдами ====

  void addDish(String name, List<String> ingredients) {
    dishes.add(Dish(name: name, requiredIngredients: ingredients));
    notifyListeners();
  }

  // Проверка: куплен ли конкретный ингредиент (есть ли он отмеченным в списке покупок)
  bool isIngredientAvailable(String ingredientName) {
    return shoppingList.any((item) =>
        item.name.toLowerCase() == ingredientName.toLowerCase() && item.isChecked);
  }

  // Сколько из ингредиентов блюда уже есть в наличии
  int countAvailableIngredients(Dish dish) {
    return dish.requiredIngredients
        .where((ingredient) => isIngredientAvailable(ingredient))
        .length;
  }

  // Добавить недостающие ингредиенты блюда в список покупок одним нажатием
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