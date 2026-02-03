import 'package:flutter/material.dart';
import 'package:collect/core/theme/theme_colors.dart';

InputDecoration textFieldInputDecoration({String hint = ''}) => InputDecoration(
  contentPadding: const EdgeInsets.only(
    left: 10,
    bottom: 10,
    top: 10,
    right: 10,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.zero),
    borderSide: BorderSide(
      color: ThemeColors.blackColor.withValues(alpha: 0.2),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.zero),
    borderSide: BorderSide(
      color: ThemeColors.blackColor.withValues(alpha: 0.2),
    ),
  ),
  hintText: hint,
);
