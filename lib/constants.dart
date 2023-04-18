import 'package:flutter/material.dart';

const Color primarySwatchColor = Color(0xFF1DA1F2);
const Color appBackgroundColor = Color(0xFFF2F2F2);
const Color fieldBorderColor = Color(0xFFE5E5E5);

const String defaultFontFamily = 'Roboto';

const TextStyle appBarTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontFamily: defaultFontFamily,
  fontWeight: FontWeight.w500,
);

const TextStyle fieldTextStyle = TextStyle(
    fontSize: 16, fontFamily: defaultFontFamily, fontWeight: FontWeight.w400);

const InputBorder fieldBorder = OutlineInputBorder(
  borderSide: BorderSide(color: fieldBorderColor),
);

const String noRecordsFoundImage = 'assets/norecordsfound.svg';

final DateTime today = DateTime.now()
    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
