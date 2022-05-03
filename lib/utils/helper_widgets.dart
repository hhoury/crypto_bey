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

Widget padButtonText(
    {String text = '', double padding = 15, bool custom = false}) {
  if (custom) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: 5),
      child: Text(text),
    );
  } else {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Text(text),
    );
  }
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
