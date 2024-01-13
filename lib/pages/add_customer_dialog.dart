// add_customer_dialog.dart

import 'package:flutter/material.dart';

import '../reusable_widgets/login_signUp_button.dart';
import '../reusable_widgets/signUp_signin_textField.dart';

class AddCustomerDialog extends StatefulWidget {
  final Function(String name, String email, String phoneNumber, String comment) onAddCustomer;

  const AddCustomerDialog({Key? key, required this.onAddCustomer}) : super(key: key);

  @override
  _AddCustomerDialogState createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Customer'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            reusableTextField('Name',  false, _nameController),
            const SizedBox(
              height: 15.0,
            ),
            reusableTextField('Email',  false, _emailController),
            const SizedBox(
              height: 15.0,
            ),
            reusableTextField('Phone Number',  false, _phoneNumberController),
            const SizedBox(
              height: 15.0,
            ),
            reusableTextField('Comment(optional)',  false, _commentController),

          ],
        ),
      ),
      actions: <Widget>[
        reusableTextButton(context,'cancel',(){Navigator.of(context).pop();},Colors.red[200]!),
        reusableElevatedButton(context, 'Add Customer', (){_addCustomer();
        Navigator.of(context).pop();}, 170.0,Colors.green[200]),

      ],
    );
  }



  void _addCustomer() {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String phoneNumber = _phoneNumberController.text.trim();
    final String comment = _commentController.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && phoneNumber.isNotEmpty) {
      widget.onAddCustomer(name, email, phoneNumber, comment);
    }
  }
}
