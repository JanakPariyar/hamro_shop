// edit_customer_dialog.dart

import 'package:flutter/material.dart';
import 'package:hamropasal/reusable_widgets/signUp_signin_textField.dart';

import '../reusable_widgets/login_signUp_button.dart';

class EditCustomerDialog extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhoneNumber;
  final String initialComment;

  EditCustomerDialog({
    required this.initialName,
    required this.initialEmail,
    required this.initialPhoneNumber,
    required this.initialComment,
  });

  @override
  _EditCustomerDialogState createState() => _EditCustomerDialogState();
}

class _EditCustomerDialogState extends State<EditCustomerDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneNumberController = TextEditingController(text: widget.initialPhoneNumber);
    _commentController = TextEditingController(text: widget.initialComment);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Customer'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          reusableTextField('Name', false, _nameController),
          const SizedBox(
            height: 15.0,
          ),
          reusableTextField('Email', false, _emailController),
          const SizedBox(
            height: 15.0,
          ),
          reusableTextField('Phone Number', false, _phoneNumberController),
          const SizedBox(
            height: 15.0,
          ),
          reusableTextField('Comment', false, _commentController),
        ],
      ),
      actions: <Widget>[
        reusableTextButton(context, 'Delete', (){Navigator.of(context).pop('delete');}, Colors.red[200]!),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        reusableElevatedButton(context, 'Save', (){Navigator.of(context).pop({
          'name': _nameController.text,
          'email': _emailController.text,
          'phoneNumber': _phoneNumberController.text,
          'comment': _commentController.text,
        });}, 90.0,Colors.green[300])
      ],
    );
  }
}
