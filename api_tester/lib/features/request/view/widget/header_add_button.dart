import 'package:flutter/material.dart';

class HeaderAddButton extends StatelessWidget {
  const HeaderAddButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(
        horizontal: 128.0,
        vertical: 8.0,
      ),
      icon: const Icon(
        Icons.add_circle_outline_rounded,
        color: Colors.grey,
      ),
      iconSize: 36.0,
      onPressed: onPressed,
    );
  }
}
