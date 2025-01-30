import 'package:api_tester/features/request/ui/type/method_ui_type.dart';
import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    color: method.color,
                    borderRadius: BorderRadius.circular(6.0)),
                child: Text(method.name.toUpperCase()),
              ),
            ),
          )
          .toList(),
    );
  }
}
