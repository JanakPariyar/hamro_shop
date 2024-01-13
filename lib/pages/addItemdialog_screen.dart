import 'package:flutter/material.dart';
import 'package:hamropasal/reusable_widgets/login_signUp_button.dart';
import 'package:hamropasal/reusable_widgets/signUp_signin_textField.dart';

class AddItemDialog extends StatefulWidget {
  @override
  _AddItemDialogState createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late TextEditingController itemNameController;
  late TextEditingController quantityController;
  late TextEditingController rateController;
  late TextEditingController payController;

  @override
  void initState() {
    super.initState();
    itemNameController = TextEditingController();
    quantityController = TextEditingController();
    rateController = TextEditingController();
    payController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Add Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          reusableTextField('item name',  false, itemNameController),
          const SizedBox(
            height: 20.0,
          ),
          reusableTextField('quantity',  false, quantityController),
          const SizedBox(
            height: 20.0,
          ),
          reusableTextField('rate', false, rateController),
          const SizedBox(
            height: 20.0,
          ),
          reusableTextField('Payment', false, payController),



        ],
      ),
      actions: [
        reusableElevatedButton( context,'Cancel',(){Navigator.pop(context);},100.0,Colors.red[200]),
        reusableElevatedButton(context, 'Add',
                (){Navigator.pop(context, {
                  'itemName': itemNameController.text,
                  'quantity': quantityController.text,
                  'rate': rateController.text,
        });},80.0,Colors.yellowAccent[200]),

      ],
    );
  }



  @override
  void dispose() {
    itemNameController.dispose();
    quantityController.dispose();
    rateController.dispose();
    super.dispose();
  }
}
