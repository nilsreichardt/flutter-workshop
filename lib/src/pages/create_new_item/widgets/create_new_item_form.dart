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
      padding: const EdgeInsets.all(8.0),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size.fromHeight(50.0),
              ),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 100),
                    content: Text('Creating day plan...'),
                  ),
                );

                if (!_formKey.currentState!.validate()) {
                  return;
                }

                widget.shoppingList.clear();

                final items = await createDayPlan(controller.text);
                for (final item in items) {
                  widget.shoppingList.addItem(item: item);
                }

                if (!mounted) {
                  return;
                }

                ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
