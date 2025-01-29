import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String _selectedMethod = 'GET';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton(
                      alignment: AlignmentDirectional.center,
                      value: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value ?? 'GET';
                        });
                      },
                      items: [
                        'GET',
                        'POST',
                        'DELETE',
                        'UPDATE',
                        'OPTION',
                        'TRACE'
                      ]
                          .map(
                            (method) => DropdownMenuItem<String>(
                              value: method,
                              child: Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    color: Colors.green.shade200,
                                    borderRadius: BorderRadius.circular(6.0)),
                                child: Text(method),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Input URL',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   icon: const Icon(
                    //     Icons.arrow_circle_right_outlined,
                    //     size: 32,
                    //   ),
                    //   onPressed: () {},
                    // ),
                  ],
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
        ));
  }
}
