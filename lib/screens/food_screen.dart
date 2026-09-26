import 'package:flutter/material.dart';

import '../data/app_data.dart';

import 'dish_detail_screen.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  void _showAddDishDialog() {
    final nameController = TextEditingController();
    final ingredientController = TextEditingController();
    final List<String> ingredients = [];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Новое блюдо'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Название блюда',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: ingredientController,
                            decoration: const InputDecoration(
                              labelText: 'Ингредиент',
                              hintText: 'Например: яйца',
                            ),
                            onSubmitted: (value) {
                              if (value.trim().isNotEmpty) {
                                setDialogState(() {
                                  ingredients.add(value.trim());
                                  ingredientController.clear();
                                });
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          onPressed: () {
                            final value = ingredientController.text.trim();
                            if (value.isNotEmpty) {
                              setDialogState(() {
                                ingredients.add(value);
                                ingredientController.clear();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (ingredients.isNotEmpty)
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ingredients.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: Text(ingredients[index]),
                              trailing: IconButton(
                                icon: const Icon(Icons.close, size: 18),
                                onPressed: () {
                                  setDialogState(() {
                                    ingredients.removeAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена'),
                ),
                FilledButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isNotEmpty && ingredients.isNotEmpty) {
                      AppData.instance.addDish(name, ingredients);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Добавить'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, _) {
        final dishes = AppData.instance.dishes;

        return Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            onPressed: _showAddDishDialog,
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: dishes.length,
            itemBuilder: (context, index) {
              final dish = dishes[index];
              final available = AppData.instance.countAvailableIngredients(
                dish,
              );
              final total = dish.requiredIngredients.length;
              final isReady = available == total;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(dish.name, style: const TextStyle(fontSize: 18)),
                  subtitle: Text('$available из $total ингредиентов есть'),
                  trailing: isReady
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : Text('$available/$total'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DishDetailScreen(dish: dish),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
