import 'package:flutter/material.dart';

class HeaderInputsListView extends StatefulWidget {
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
  State<HeaderInputsListView> createState() => _HeaderInputsListViewState();
}

class _HeaderInputsListViewState extends State<HeaderInputsListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      scrollbarOrientation: ScrollbarOrientation.right,
      thumbVisibility: true,
      interactive: true,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: widget.keyControllers.length,
        itemBuilder: (_, index) => Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 1,
              child: TextField(
                controller: widget.keyControllers[index],
                keyboardType: TextInputType.text,
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
                controller: widget.valueControllers[index],
                keyboardType: TextInputType.text,
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
              onPressed: () => widget.onRemovePressed(index),
            ),
            const SizedBox(width: 4.0),
          ],
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12.0),
      ),
    );
  }
}
