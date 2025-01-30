import 'package:flutter/material.dart';

class UrlTextField extends StatelessWidget {
  const UrlTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: 'Input URL',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
