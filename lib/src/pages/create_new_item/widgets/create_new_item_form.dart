import 'package:flutter/material.dart';
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
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a daily goal';
                      }
                      return null;
                    },
                    controller: _nameController,
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
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                final name = _nameController.text;
                widget.shoppingList.addItem(
                  name: name,
                );
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
