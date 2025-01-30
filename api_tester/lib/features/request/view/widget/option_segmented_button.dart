import 'package:flutter/material.dart';

import '../type/request_option_type.dart';

class OptionSegmentedButton extends StatelessWidget {
  const OptionSegmentedButton({
    super.key,
    required this.option,
    required this.onSelectionChanged,
  });

  final RequestOptionType option;
  final void Function(Set<RequestOptionType> newOptions) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<RequestOptionType>(
      showSelectedIcon: false,
      segments: RequestOptionType.values
          .map(
            (option) => ButtonSegment<RequestOptionType>(
              value: option,
              label: Text(option.name),
            ),
          )
          .toList(),
      selected: {option},
      onSelectionChanged: onSelectionChanged,
    );
  }
}
