import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double getBottomInsets(BuildContext context) {
  if (MediaQuery.of(context).viewInsets.bottom >
      MediaQuery.of(context).viewPadding.bottom) {
    return MediaQuery.of(context).viewInsets.bottom -
        MediaQuery.of(context).viewPadding.bottom;
  }
  return 0;
}

String getDateinDateFormat(DateTime date) =>
    DateFormat('d MMM yyyy').format(date);

DateTime parseDateString(String dateString) =>
    DateFormat('d MMM yyyy').parse(dateString);
