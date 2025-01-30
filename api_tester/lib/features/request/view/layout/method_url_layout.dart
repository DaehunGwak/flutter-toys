import 'package:flutter/material.dart';

import '../type/method_ui_type.dart';
import '../widget/method_dropdown_button.dart';
import '../widget/url_text_field.dart';

class MethodUrlLayout extends StatelessWidget {
  const MethodUrlLayout({
    super.key,
    required this.method,
    required this.onMethodChanged,
    required this.urlController,
  });

  final MethodUiType method;
  final void Function(MethodUiType? value) onMethodChanged;
  final TextEditingController urlController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.5),
          child: MethodDropdownButton(
            method: method,
            onChanged: onMethodChanged,
          ),
        ),
        Expanded(
          child: UrlTextField(controller: urlController),
        ),
      ],
    );
  }
}
