import 'package:flutter/material.dart';

// تحديث دالة transformErrors لدعم الرسائل المخصصة لحالة ايميل غير موجود
Widget transformErrors(Map<String, dynamic> errors,
    {String singleError = '', bool emailNotFound = false}) {
  // List to store error message widgets.
  List<Widget> errorWidgets = [];

  // If a single error message is provided, add it to the list of widgets.
  if (singleError.isNotEmpty && errors.isEmpty) {
    errorWidgets.add(Text(
      singleError,
      style: TextStyle(color: Colors.red),
    ));
  } else if (singleError.isNotEmpty && errors.isNotEmpty) {
    // If both a single error and a map of errors are provided, add the single error to the list of widgets.
    errorWidgets.add(Text(
      singleError,
      style: TextStyle(color: Colors.red),
    ));

    // Iterate over each key-value pair in the errors map.
    errors.forEach((input, messages) {
      // For each message associated with the input, add it to the list of widgets.
      for (String msg in messages) {
        errorWidgets.add(Text(
          msg,
          style: TextStyle(color: Colors.red),
        ));
      }
    });
  } else {
    // If no single error is provided, iterate through the map of errors.

    // Iterate over each key-value pair in the errors map.
    errors.forEach((input, messages) {
      // For each message associated with the input, add it to the list of widgets.
      for (String msg in messages) {
        errorWidgets.add(Text(
          msg,
          style: TextStyle(color: Colors.red),
        ));
      }
    });
  }

  // إذا كانت الرسالة مخصصة لحالة ايميل غير موجود، قم بإضافة رسالة خاصة
  if (emailNotFound) {
    errorWidgets.add(Text(
      'Email not found',
      style: TextStyle(color: Colors.red),
    ));
  }

  // Return the list of error message widgets.
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: errorWidgets,
  );
}
