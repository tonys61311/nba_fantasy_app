import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/simple_icons.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.isAsync = true,
  });

  final String label;
  final FutureOr<void> Function()? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isAsync; // if true, auto controls isLoading when async

  factory AppButton.google({
    Key? key,
    required FutureOr<void> Function()? onPressed,
    String? label,
  }) {
    return AppButton(
      key: key,
      label: label ?? 'Sign in with Google',
      onPressed: onPressed,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      icon: Builder(
        builder: (context) => Iconify(
          SimpleIcons.google,
          size: 20,
          color: IconTheme.of(context).color,
        ),
      ),
      isAsync: true,
    );
  }

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    if (widget.onPressed == null) return;

    final FutureOr<void> result = widget.onPressed!();
    if (widget.isAsync && result is Future) {
      setState(() => _isLoading = true);
      try {
        await result;
      } finally {
        if (!mounted) return;
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color effectiveForeground =
        widget.foregroundColor ?? colorScheme.onSurface;

    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: widget.backgroundColor ??
          colorScheme.surfaceContainerHighest.withOpacity(0.25),
      foregroundColor: effectiveForeground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );

    final bool isDisabled = widget.onPressed == null || (widget.isAsync && _isLoading);

    return ElevatedButton(
      onPressed: isDisabled ? null : _handlePress,
      style: style,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: (widget.isAsync && _isLoading)
            ? const SizedBox(
                key: ValueKey('loading'),
                height: 20,
                width: 20,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              )
            : IconTheme(
                data: IconThemeData(color: effectiveForeground),
                child: Row(
                key: const ValueKey('content'),
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    widget.icon!,
                    const SizedBox(width: 12),
                  ],
                    Text(
                      widget.label,
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(
                            fontWeight: FontWeight.w700,
                            color: effectiveForeground,
                          ),
                    ),
                ],
                ),
              ),
      ),
    );
  }
}


