import 'package:flutter/material.dart';

import '../model/request.dart';
import 'layout/bottom_request_layout.dart';
import 'layout/method_url_layout.dart';
import 'layout/option_input_layout.dart';
import 'type/method_ui_type.dart';
import 'type/request_option_type.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _urlFieldController = TextEditingController();

  final RequestHeaders _headers = {};
  MethodUiType _selectedMethod = MethodUiType.get;
  RequestOptionType _selectedOption = RequestOptionType.headers;

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
              const SizedBox(height: 16.0),
              OptionInputLayout(
                option: _selectedOption,
                onOptionSelectionChanged: (newOptions) {
                  _selectedOption = newOptions.first;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomRequestLayout(),
    );
  }
}
