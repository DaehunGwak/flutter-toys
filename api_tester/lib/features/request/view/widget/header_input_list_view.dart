import 'package:flutter/material.dart';

class HeaderInputsListView extends StatelessWidget {
  const HeaderInputsListView({
    super.key,
    required this.keyControllers,
    required this.valueControllers,
    required this.onRemovePressed,
  });

  final List<TextEditingController> keyControllers;
  final List<TextEditingController> valueControllers;
  final void Function(int index) onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: keyControllers.length,
      itemBuilder: (_, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            flex: 1,
            child: TextField(
              controller: keyControllers[index],
              maxLines: null,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Key',
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Flexible(
            flex: 2,
            child: TextField(
              controller: valueControllers[index],
              maxLines: null,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Value',
              ),
            ),
          ),
          IconButton(
            color: Colors.orange,
            icon: const Icon(Icons.remove_circle_outline_outlined),
            onPressed: () => onRemovePressed(index),
          )
        ],
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12.0),
    );
  }
}
