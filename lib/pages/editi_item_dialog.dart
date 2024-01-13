import 'package:flutter/material.dart';
import 'package:hamropasal/reusable_widgets/signUp_signin_textField.dart';
import 'package:hive/hive.dart';

import '../models/transaction.dart';

class EditItemDialog extends StatefulWidget {
  final Transaction initialTransaction; // Pass the initial transaction to the dialog
  final Box<Transaction> transactionBox;
  EditItemDialog({
    required this.initialTransaction,
    required double initialPaidAmount,
    required double initialRate,
    required double initialQuantity,
    required String initialItemName,
    required this.transactionBox,
  });

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  late TextEditingController itemNameController;
  late TextEditingController quantityController;
  late TextEditingController rateController;
  late TextEditingController paidAmountController;
  late Transaction currentTransaction; // Store the current transaction in the state

  @override
  void initState() {
    super.initState();
    currentTransaction = widget.initialTransaction;
    itemNameController = TextEditingController(text: currentTransaction.itemName);
    quantityController = TextEditingController(text: currentTransaction.itemQuantity.toString());
    rateController = TextEditingController(text: currentTransaction.itemRate.toString());
    paidAmountController = TextEditingController(text: currentTransaction.paidAmount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          reusableTextField('Item Name', false, itemNameController),
          const SizedBox(height: 15.0),
          reusableTextField('Quantity', false, quantityController),
          const SizedBox(height: 15.0),
          reusableTextField('Rate', false, rateController),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'itemName': itemNameController.text,
              'quantity': quantityController.text,
              'rate': rateController.text,
              'paidAmount': paidAmountController.text,
            });
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            _deleteItem();

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Set the delete button color to red
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }

  void _deleteItem() {
    final key = currentTransaction.key;
    widget.transactionBox.delete(key);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    itemNameController.dispose();
    quantityController.dispose();
    rateController.dispose();
    paidAmountController.dispose();
    super.dispose();
  }
}
