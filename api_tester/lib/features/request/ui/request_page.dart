import 'package:api_tester/features/request/ui/layout/bottom_request_layout.dart';
import 'package:api_tester/features/request/ui/type/method_ui_type.dart';
import 'package:flutter/material.dart';

import 'layout/method_url_layout.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _urlFieldController = TextEditingController();

  MethodUiType _selectedMethod = MethodUiType.get;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              MethodUrlLayout(
                method: _selectedMethod,
                onMethodChanged: (value) {
                  _selectedMethod = value ?? MethodUiType.get;
                  setState(() {});
                },
                urlController: _urlFieldController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomRequestLayout(),
    );
  }
}
