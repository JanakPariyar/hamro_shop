import 'package:flutter/material.dart';

Container LoginSignupButton(BuildContext context, String title, Function onTap, double width, Color color) {
  return Container(
    width: width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return color;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );

}

Container reusableElevatedButton(
    BuildContext context,
    String title,
    Function onTap,
    double? width,
    [Color? color]
    ) {
  return Container(
    width: width ?? 80.0,
    height: 35.0,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

TextButton reusableTextButton(BuildContext context,String label,Function onTap,Color color) {
  return TextButton(
    onPressed: () {
      onTap();
    },
    child: Text('$label',style: TextStyle(color: color),),
  );
}
