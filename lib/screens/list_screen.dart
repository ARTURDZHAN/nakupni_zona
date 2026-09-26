import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class ShoppingItem {
  String name;
  bool isChecked;

  ShoppingItem({required this.name, this.isChecked = false});
}

class _ListScreenState extends State<ListScreen> {
  final List<ShoppingItem> _items = [
    ShoppingItem(name: 'Молоко'),
    ShoppingItem(name: 'Хлеб'),
    ShoppingItem(name: 'Яйца'),
  ];

  final TextEditingController _controller = TextEditingController();

  void _addItem(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      _items.add(ShoppingItem(name: name.trim()));
    });
    _controller.clear();
  }

  void _toggleItem(int index) {
    setState(() {
      _items[index].isChecked = !_items[index].isChecked;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Поле ввода нового товара
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
                  onSubmitted: _addItem, // добавление по Enter
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.add_circle, size: 32),
                onPressed: () => _addItem(_controller.text),
              ),
            ],
          ),
        ),

        // Сам список товаров
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 80), // отступ под панель навигации
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              return CheckboxListTile(
                title: Text(
                  item.name,
                  style: TextStyle(
                    decoration: item.isChecked
                        ? TextDecoration.lineThrough // зачёркивание отмеченных
                        : TextDecoration.none,
                    color: item.isChecked ? Colors.grey : Colors.black,
                  ),
                ),
                value: item.isChecked,
                onChanged: (_) => _toggleItem(index),
                secondary: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _removeItem(index),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}