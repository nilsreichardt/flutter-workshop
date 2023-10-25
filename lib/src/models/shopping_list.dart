class ShoppingList {
  final List<ShoppingListItem> items;

  static int _nextId = 0;

  ShoppingList() : items = [];

  void addItem({
    required String name,
  }) {
    items.add(
      ShoppingListItem(
        id: _nextId++,
        name: name,
        isBought: false,
      ),
    );
  }
}

class ShoppingListItem {
  final int id;
  final String name;
  bool isBought;

  ShoppingListItem({
    required this.id,
    required this.name,
    required this.isBought,
  });
}
