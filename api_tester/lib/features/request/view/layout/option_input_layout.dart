import 'package:flutter/material.dart';

import '../type/request_option_type.dart';
import '../widget/option_segmented_button.dart';

class OptionInputLayout extends StatelessWidget {
  const OptionInputLayout({
    super.key,
    required this.option,
    required this.onOptionSelectionChanged,
  });

  final RequestOptionType option;
  final void Function(Set<RequestOptionType> newOptions)
      onOptionSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OptionSegmentedButton(
          option: option,
          onSelectionChanged: onOptionSelectionChanged,
        ),
      ],
    );
  }
}
