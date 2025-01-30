import 'package:flutter/material.dart';

import '../type/method_ui_type.dart';

class MethodDropdownButton extends StatelessWidget {
  const MethodDropdownButton({
    super.key,
    required this.method,
    required this.onChanged,
  });

  final MethodUiType method;
  final void Function(MethodUiType? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      alignment: AlignmentDirectional.center,
      value: method,
      onChanged: onChanged,
      items: MethodUiType.values
          .map(
            (method) => DropdownMenuItem<MethodUiType>(
              value: method,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 9.0,
                ),
                decoration: BoxDecoration(
                  color: method.color,
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  method.name.toUpperCase(),
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
