import 'package:flutter/material.dart';

import '../type/request_option_type.dart';
import '../widget/header_add_button.dart';
import '../widget/header_input_list_view.dart';
import '../widget/option_segmented_button.dart';

class OptionInputLayout extends StatelessWidget {
  const OptionInputLayout({
    super.key,
    required this.option,
    required this.onOptionSelectionChanged,
    required this.headerKeyControllers,
    required this.headerValueControllers,
    required this.onHeaderAddPressed,
    required this.onHeaderRemovePressed,
  });

  final RequestOptionType option;
  final void Function(Set<RequestOptionType> newOptions)
      onOptionSelectionChanged;
  final List<TextEditingController> headerKeyControllers;
  final List<TextEditingController> headerValueControllers;
  final void Function() onHeaderAddPressed;
  final void Function(int index) onHeaderRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionSegmentedButton(
          option: option,
          onSelectionChanged: onOptionSelectionChanged,
        ),
        if (option == RequestOptionType.headers) ...[
          Expanded(
            child: HeaderInputsListView(
              keyControllers: headerKeyControllers,
              valueControllers: headerValueControllers,
              onRemovePressed: onHeaderRemovePressed,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: HeaderAddButton(
              onPressed: onHeaderAddPressed,
            ),
          ),
        ] else
          const Text('Developing... 😂'),
        const SizedBox(height: 16.0)
      ],
    );
  }
}
