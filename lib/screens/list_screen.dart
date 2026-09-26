import 'package:flutter/material.dart';
import '../data/app_data.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder перестраивает этот экран каждый раз,
    // когда AppData вызывает notifyListeners()
    return AnimatedBuilder(
      animation: AppData.instance,
      builder: (context, _) {
        final items = AppData.instance.shoppingList;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Добавить товар...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) {
                        AppData.instance.addShoppingItem(value);
                        _controller.clear();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.add_circle, size: 32),
                    onPressed: () {
                      AppData.instance.addShoppingItem(_controller.text);
                      _controller.clear();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return CheckboxListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                        decoration: item.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: item.isChecked ? Colors.grey : Colors.black,
                      ),
                    ),
                    value: item.isChecked,
                    onChanged: (_) => AppData.instance.toggleShoppingItem(index),
                    secondary: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => AppData.instance.removeShoppingItem(index),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}