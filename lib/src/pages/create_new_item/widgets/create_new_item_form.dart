import 'package:flutter/material.dart';
import 'package:shopping_list/src/logic/create_day_plan.dart';
import 'package:shopping_list/src/models/shopping_list.dart';

class CreateNewItemForm extends StatefulWidget {
  const CreateNewItemForm({
    super.key,
    required this.shoppingList,
  });

  final ShoppingList shoppingList;

  @override
  State<CreateNewItemForm> createState() => _CreateNewItemFormState();
}

class _CreateNewItemFormState extends State<CreateNewItemForm> {
  late TextEditingController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a daily goal';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Daily goal',
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: isLoading
                  ? Image.network(
                      "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNHdxdXV1NzZveW80MjkxcGtocW14eHp1bGY0cnZiamV3eXNqeGI0aiZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7bu8sRnYpTOG1p8k/giphy.gif",
                      height: 200,
                    )
                  : Container(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size.fromHeight(50.0),
              ),
              onPressed: isLoading
                  ? null
                  : () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      setState(() {
                        isLoading = true;
                      });

                      widget.shoppingList.goal = controller.text;
                      widget.shoppingList.clear();

                      final items = await createDayPlan(controller.text);
                      for (final item in items) {
                        widget.shoppingList.addItem(item: item);
                      }

                      // FOR DEMO PURPOSES ONLY
                      // await Future.delayed(const Duration(seconds: 3));
                      // widget.shoppingList.addItem(
                      //   item: ShoppingListItem(
                      //     id: 0,
                      //     name: 'Buy a new car',
                      //     reason: 'You need a car to get to work',
                      //     isBought: false,
                      //   ),
                      // );
                      // widget.shoppingList.addItem(
                      //   item: ShoppingListItem(
                      //     id: 1,
                      //     name: 'Buy a new house',
                      //     reason: 'You need a house to live in',
                      //     isBought: false,
                      //   ),
                      // );
                      // widget.shoppingList.addItem(
                      //   item: ShoppingListItem(
                      //     id: 2,
                      //     name: 'Buy a new phone',
                      //     reason: 'You need a phone to call your friends',
                      //     isBought: false,
                      //   ),
                      // );

                      if (!mounted) {
                        return;
                      }

                      Navigator.of(context).pop();
                    },
              child: const Text(
                'Set',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
