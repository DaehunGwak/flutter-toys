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
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
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
      ),
    );
  }
}
