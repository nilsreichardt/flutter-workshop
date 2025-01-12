import 'package:flutter/material.dart';
import 'package:shopping_list/src/models/shopping_list.dart';
import 'package:shopping_list/src/pages/create_new_item/create_new_item_page.dart';
import 'package:shopping_list/src/pages/home/widgets/shopping_list_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ShoppingList _shoppingList = ShoppingList("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Your ToDos for your goal "${_shoppingList.goal}"'),
      ),
      body: ShoppingListView(
        shoppingList: _shoppingList,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Set daily goal',
        onPressed: () async {
          await Navigator.of(context).push<(int, String)>(
            MaterialPageRoute(
              builder: (context) {
                return CreateNewShoppingListItemPage(
                  shoppingList: _shoppingList,
                );
              },
            ),
          );
          if (mounted) {
            setState(() {
              // rerender
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
