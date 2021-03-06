import 'package:flutter/material.dart';

InputDecoration getFormDecoration(
    BuildContext context, bool enabled, String label) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;
  return InputDecoration(
    floatingLabelStyle: TextStyle(color: theme.primaryColor),
    contentPadding: const EdgeInsets.fromLTRB(16, 18, 24, 14),
    enabled: enabled,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: theme.primaryColor, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: theme.disabledColor, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: theme.disabledColor, width: 1),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: theme.errorColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: theme.errorColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    labelText: label,
    errorText: null,
    errorStyle: textTheme.subtitle2?.copyWith(color: theme.errorColor),
    fillColor: Colors.transparent,
    filled: true,
  );
}

InputDecoration getTextFieldDecoration({
  required BuildContext context,
  required bool enabled,
  required String label,
  required bool isInvalid,
}) {
  return getFormDecoration(context, enabled, label).copyWith(
    suffixIcon: isInvalid
        ? Icon(
            Icons.error_outline,
            color: Theme.of(context).errorColor,
            size: 24,
          )
        : null,
  );
}
