import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class RequestBottomLayout extends StatelessWidget {
  const RequestBottomLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: Platform.isMacOS
            ? const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0)
            : const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Send Request',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 16.0),
                Icon(Icons.send_rounded)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
