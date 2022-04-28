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
      widthFactor: 1,
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

Widget inputLabel(BuildContext context, String label) {
  return Text(label, style: Theme.of(context).textTheme.labelMedium);
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
