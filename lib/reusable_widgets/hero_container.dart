import 'package:flutter/material.dart';

Container container(double totalAmount,String label,Color color) {
  return Container(
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.black12,width: 1.0)
    ),
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        Text(
            '$label',
            style:  const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0
            )),
        Text('$totalAmount',
          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
        ),
      ],
    ),

  );
}