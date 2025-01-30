import 'package:flutter/material.dart';

class RequestAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RequestAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super();

  @override
  final Size preferredSize;

  @override
  State<RequestAppBar> createState() => _RequestAppBarState();
}

class _RequestAppBarState extends State<RequestAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: const Text(
        'Request',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
