import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/dish.dart';

class DishDetailScreen extends StatefulWidget {
  final Dish dish;

  const DishDetailScreen({super.key, required this.dish});

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, _) {
        final available = AppData.instance.countAvailableIngredients(widget.dish);
        final total = widget.dish.requiredIngredients.length;
        final isReady = available == total;

        return Scaffold(
          appBar: AppBar(title: Text(widget.dish.name)),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: isReady
                    ? Colors.green.withValues(alpha: 0.15)
                    : Colors.orange.withValues(alpha: 0.15),
                child: Text(
                  isReady ? '✅ Можно готовить!' : '⚠️ Не хватает ингредиентов',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.dish.requiredIngredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = widget.dish.requiredIngredients[index];
                    final hasIt = AppData.instance.isIngredientAvailable(ingredient);

                    return ListTile(
                      leading: Icon(
                        hasIt ? Icons.check_circle : Icons.cancel,
                        color: hasIt ? Colors.green : Colors.grey,
                      ),
                      title: Text(
                        ingredient,
                        style: TextStyle(
                          decoration: hasIt ? null : TextDecoration.none,
                          color: hasIt ? Colors.black : Colors.black54,
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (!isReady)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Добавить недостающее в список'),
                      onPressed: () {
                        AppData.instance
                            .addMissingIngredientsToShoppingList(widget.dish);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ингредиенты добавлены в список покупок'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}