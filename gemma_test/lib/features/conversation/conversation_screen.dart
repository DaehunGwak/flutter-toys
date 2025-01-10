import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma_interface.dart';
import 'package:gemma_test/features/conversation/widget/message_widget.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.title});

  final String title;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();

    _loadModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToEndMessage();
    });
  }

  void _loadModel() {
    FlutterGemmaPlugin.instance
        .loadAssetModelWithProgress(
            fullPath: 'model/gemma-1.1-2b-it-cpu-int4.bin')
        .listen(
      (progress) => debugPrint('model progress: $progress'),
      onDone: () async {
        await FlutterGemmaPlugin.instance.init();
        debugPrint('model is loaded!');
      },
      onError: (error) {
        debugPrint('model error: $error');
      },
    );
  }

  void _jumpToEndMessage() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: _messages
                        .mapIndexed(
                          (index, message) => MessageWidget(
                            message: message,
                            isUser: index.isEven,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SearchBar(
                controller: _textController,
                textInputAction: TextInputAction.newline,
                hintText: 'Ask something your on-device AI',
                trailing: [
                  IconButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        setState(() {
                          _messages.add(_textController.text.trim());
                        });
                        _textController.clear();
                        _jumpToEndMessage();
                      }
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
