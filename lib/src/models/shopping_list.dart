class ShoppingList {
  final List<ShoppingListItem> items;

  static int _nextId = 0;

  ShoppingList() : items = [];

  void addItem({
    required ShoppingListItem item,
  }) {
    items.add(item);
  }

  void clear() {
    items.clear();
  }
}

class ShoppingListItem {
  final int id;
  final String name;
  final String reason;
  bool isBought;

  ShoppingListItem({
    required this.id,
    required this.name,
    required this.isBought,
    required this.reason,
  });
}
