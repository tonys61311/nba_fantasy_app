import 'package:flutter/material.dart';

enum AppTextFieldType {
  text,
  email,
  password,
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.label,
    this.type = AppTextFieldType.text,
    this.keyboardType,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? label;
  final AppTextFieldType type;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool isPassword = widget.type == AppTextFieldType.password;
    final TextInputType effectiveKeyboardType = widget.keyboardType ??
        (widget.type == AppTextFieldType.email
            ? TextInputType.emailAddress
            : TextInputType.text);

    return TextField(
      controller: widget.controller,
      keyboardType: effectiveKeyboardType,
      obscureText: isPassword ? _obscurePassword : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(
                  () => _obscurePassword = !_obscurePassword,
                ),
              )
            : null,
      ),
    );
  }
}


