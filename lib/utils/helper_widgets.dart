import 'package:flutter/material.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget buttonContainer(Widget button) {
  return Align(
    alignment: Alignment.center,
    child: FractionallySizedBox(
      widthFactor: 0.9,
      child: button,
    ),
  );
}

Widget padButtonText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Text(text),
  );
}

// Widget textFormFieldContainer(Widget field) {
//   return TextFormField(
//     decoration: InputDecoration(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       filled: true,
//     ),
//   );
// }
