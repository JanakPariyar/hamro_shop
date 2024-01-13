import 'package:flutter/material.dart';
import 'package:hamropasal/reusable_widgets/login_signUp_button.dart';
import 'package:hamropasal/reusable_widgets/signUp_signin_textField.dart';
import 'package:hive/hive.dart';

import '../models/transaction.dart';

class PaymentEditDialog extends StatefulWidget {
  final Transaction initialTransaction; // Pass the initial transaction to the dialog
  final Box<Transaction> transactionBox;

  PaymentEditDialog({
    required this.initialTransaction,

    required String initialItemName,
    required double initialPaidAmount,
    required this.transactionBox,

  });

  @override
  _PaymentEditDialogState createState() => _PaymentEditDialogState();
}

class _PaymentEditDialogState extends State<PaymentEditDialog> {
  late TextEditingController itemNameController;
  late TextEditingController paidAmountController;
  late Transaction currentTransaction;

  @override
  void initState() {
    super.initState();
    currentTransaction = widget.initialTransaction;
    itemNameController = TextEditingController(text: currentTransaction.itemName);
    paidAmountController = TextEditingController(text: currentTransaction.paidAmount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Payment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          reusableTextField('Payment Method', false, itemNameController),
          SizedBox(
            height: 15.0,
          ),
          reusableTextField('Amount', false, paidAmountController),
        ],
      ),
      actions: [
        reusableTextButton(context, 'Cancel', (){Navigator.pop(context);}, Colors.red[200]!),
        reusableElevatedButton(context, 'Save', (){
          Navigator.pop(context, {
            'itemName': itemNameController.text,
            'paidAmount': paidAmountController.text,
          });
        }, 100.0, Colors.blue[300]),
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
  }// Change the color as needed

void _deleteItem() {
  final key = currentTransaction.key;
  widget.transactionBox.delete(key);
  Navigator.pop(context);
}
  @override
  void dispose() {
    itemNameController.dispose();
    paidAmountController.dispose();
    super.dispose();
  }
}
