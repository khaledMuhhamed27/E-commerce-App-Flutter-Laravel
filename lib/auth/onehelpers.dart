transformErrors(Map<String, dynamic> errors, {String singleError = ''}) {
  // Placeholder for the resulting error message string.
  String message = '';

  // If a single error message is provided, add it to the message string.
  if (singleError.isNotEmpty && errors.isEmpty) {
    message += '- $singleError \n';
  } else if (singleError.isNotEmpty && errors.isNotEmpty) {
    // If both a single error and a map of errors are provided, add the single error to the message string.
    message += '- $singleError \n';

    // Iterate over each key-value pair in the errors map.
    errors.forEach((input, messages) {
      // For each message associated with the input, append it to the message string.
      for (String msg in messages) {
        message += '- $msg \n';
      }
    });
  } else {
    // If no single error is provided, iterate through the map of errors.

    // Iterate over each key-value pair in the errors map.
    errors.forEach((input, messages) {
      // For each message associated with the input, append it to the message string.
      for (String msg in messages) {
        message += '- $msg \n';
      }
    });
  }

  // Return the formatted error message string.
  return message;
}
