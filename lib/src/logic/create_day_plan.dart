import 'dart:convert';

import 'package:shopping_list/src/logic/gpt_api.dart';
import 'package:shopping_list/src/models/shopping_list.dart';

Future<List<ShoppingListItem>> createDayPlan(String dayGoal) async {
  final response = await getGptResponse(getPrompt('Study for an exam'));
  final jsonItems = jsonDecode(response) as List<dynamic>;

  final shoppingListItems = <ShoppingListItem>[];
  for (final jsonItem in jsonItems) {
    shoppingListItems.add(
      ShoppingListItem(
        id: 0,
        name: jsonItem['title'] as String,
        isBought: false,
        reason: jsonItem['reason'] as String,
      ),
    );
  }

  return shoppingListItems;
}
