import 'package:flutter/material.dart';

DataColumn dataColumn(String label) {
  return DataColumn(
      label: Text('$label',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ));
}