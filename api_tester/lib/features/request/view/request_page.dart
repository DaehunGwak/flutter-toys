import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../config/dio.dart';
import '../model/request.dart';
import 'layout/method_url_layout.dart';
import 'layout/option_input_layout.dart';
import 'layout/request_bottom_layout.dart';
import 'type/method_ui_type.dart';
import 'type/request_option_type.dart';
import 'widget/request_app_bar.dart';

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
  bool _isRequestWaiting = false;

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
    return Stack(
      children: [
        Scaffold(
          appBar: const RequestAppBar(),
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
          bottomNavigationBar: RequestBottomLayout(
            onRequestPressed: () async {
              _isRequestWaiting = true;
              setState(() {});

              final RequestHeaders headers = {};
              for (var i = 0; i < _headerKeyControllers.length; i++) {
                final trimmedKey = _headerKeyControllers[i].text.trim();
                if (trimmedKey.isEmpty) {
                  continue;
                }
                headers[trimmedKey] = _headerValueControllers[i].text.trim();
              }

              final request = Request(
                method: _selectedMethod.toMethodType(),
                url: _urlFieldController.text.trim(),
                headers: headers,
              );

              String? message;

              try {
                final started = DateTime.now();
                final response = await dio.request(
                  request.url,
                  options: Options(
                    method: request.method.name,
                    headers: request.headers,
                  ),
                );
                message = '''Duration: ${DateTime.now().difference(started)}
                
Request:
${response.requestOptions.method} ${'${response.requestOptions.uri.path}${response.requestOptions.uri.query.isEmpty ? '' : '?'}${response.requestOptions.uri.query}'}
Host: ${response.requestOptions.uri.host}
${response.requestOptions.headers.entries.map((entry) => '${entry.key}: ${entry.value}').join('\n')}

Response: ${response.statusCode}, ${response.statusMessage}
${response.headers}
$response''';
              } on DioException catch (e) {
                message = e.toString();
              }

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    showCloseIcon: true,
                    backgroundColor: Colors.black.withOpacity(0.8),
                    duration: const Duration(days: 1),
                    content: Container(
                      constraints: const BoxConstraints(maxHeight: 400),
                      child: RawScrollbar(
                        radius: const Radius.circular(20),
                        thickness: 3,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          child: Text(message),
                        ),
                      ),
                    ),
                  ),
                );
              }

              _isRequestWaiting = false;
              setState(() {});
            },
          ),
        ),
        if (_isRequestWaiting)
          Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          )
      ],
    );
  }
}
