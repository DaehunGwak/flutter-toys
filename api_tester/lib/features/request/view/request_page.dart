import 'package:flutter/material.dart';

import 'layout/method_url_layout.dart';
import 'layout/option_input_layout.dart';
import 'layout/request_bottom_layout.dart';
import 'type/method_ui_type.dart';
import 'type/request_option_type.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _urlFieldController = TextEditingController();
  final List<TextEditingController> _headerKeyControllers = [
    TextEditingController()
  ];
  final List<TextEditingController> _headerValueControllers = [
    TextEditingController()
  ];

  MethodUiType _selectedMethod = MethodUiType.get;
  RequestOptionType _selectedOption = RequestOptionType.headers;

  @override
  void dispose() {
    _urlFieldController.dispose();
    for (var controller in _headerKeyControllers) {
      controller.dispose();
    }
    for (var controller in _headerValueControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Request',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
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
              Expanded(
                child: OptionInputLayout(
                  option: _selectedOption,
                  onOptionSelectionChanged: (newOptions) {
                    _selectedOption = newOptions.first;
                    setState(() {});
                  },
                  headerKeyControllers: _headerKeyControllers,
                  headerValueControllers: _headerValueControllers,
                  onHeaderAddPressed: () {
                    _headerKeyControllers.add(TextEditingController());
                    _headerValueControllers.add(TextEditingController());
                    setState(() {});
                  },
                  onHeaderRemovePressed: (int index) {
                    _headerKeyControllers.removeAt(index);
                    _headerValueControllers.removeAt(index);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const RequestBottomLayout(),
    );
  }
}
