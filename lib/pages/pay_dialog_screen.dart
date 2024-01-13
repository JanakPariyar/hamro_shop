import 'package:flutter/material.dart';
import 'package:hamropasal/reusable_widgets/login_signUp_button.dart';
import 'package:hamropasal/reusable_widgets/signUp_signin_textField.dart';

class PayItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<PayItemDialog> {
  late TextEditingController itemNameController;
  late TextEditingController payController;

  @override
  void initState() {
    super.initState();
    itemNameController = TextEditingController();

    payController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pay'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          reusableTextField('Payment Method', false, itemNameController),
          SizedBox(
            height: 15.0,
          ),
          reusableTextField('Amount', false, payController),

        ],
      ),
      actions: [
        reusableTextButton(context, 'Cancel', (){Navigator.pop(context);}, Colors.red[200]!),
        reusableElevatedButton(context, 'Paid', (){Navigator.pop(context, {
        'itemName': itemNameController.text,
        'pay':payController.text,
        });}, 100.0,Colors.green[300])
      ],
    );
  }

  @override
  void dispose() {
    itemNameController.dispose();

    super.dispose();
  }
}
