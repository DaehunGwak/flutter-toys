import 'package:flutter/material.dart';

class HeaderAddButton extends StatelessWidget {
  const HeaderAddButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: IconButton(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        icon: const Icon(
          Icons.add_circle_outline_rounded,
          color: Colors.grey,
        ),
        iconSize: 36.0,
        onPressed: onPressed,
      ),
    );
  }
}
