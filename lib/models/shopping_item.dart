enum ItemPriority { essential, notNecessary, optional }

class ShoppingItem {
  String name;
  bool isChecked;
  ItemPriority priority;

  ShoppingItem({
    required this.name,
    this.isChecked = false,
    this.priority = ItemPriority.essential,
  });
}