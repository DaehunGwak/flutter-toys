import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:gemma_test/features/conversation/widget/message_widget.dart';

/// ref: https://cloud.google.com/dataflow/docs/notebooks/gemma_2_sentiment_and_summarization
class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.title});

  final String title;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  final List<Message> _gemmaMessages = [];

  int _progress = 0;
  bool _isPossibleChatInput = false;

  @override
  void initState() {
    super.initState();

    _loadModel();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToEndMessage();
    });
  }

  Future<void> _loadModel() async {
    if (_isPossibleChatInputMode()) {
      debugPrint('${DateTime.now()}: gemma is already initialized');
      return;
    }

    debugPrint('${DateTime.now()}: model loading started: $_progress');

    FlutterGemmaPlugin.instance
        .loadAssetModelWithProgress(
            fullPath: 'model/gemma-1.1-2b-it-cpu-int4.bin')
        .listen(
      (progress) {
        if (_progress != progress) {
          if (progress % 20 == 0) {
            debugPrint('${DateTime.now()}: model progress: $progress');
          }
          setState(() {
            _progress = progress;
          });
        }
      },
      onDone: () async {
        await FlutterGemmaPlugin.instance.init(
          temperature: 1.0,
          maxTokens: 1024,
        );
        setState(() {
          _isPossibleChatInput = true;
        });
        debugPrint('${DateTime.now()}: model is loaded!');
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
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _gemmaMessages.clear();
              });
            },
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
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
                    children: _gemmaMessages
                        .map(
                          (message) => MessageWidget(
                            message: message.text,
                            isUser: message.isUser,
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
                enabled: _isPossibleChatInputMode(),
                textInputAction: TextInputAction.newline,
                hintText: 'Ask something your on-device AI',
                trailing: [
                  IconButton(
                    onPressed: _isPossibleChatInputMode()
                        ? () {
                            if (_textController.text.isNotEmpty) {
                              _sendMessage(
                                '''
Provide the results of doing these three tasks on the text provided below '---'
task 1 : assess if the tone is happy = 1 , neutral = 0 or sad = -1
task 2 : assess if the tone is depressed = 1 , neutral = 0 or joyful = -1
task 3 : summarize the text with a maximum of 512 characters
Return the answer as a JSON string with fields [happy, depressed, summary] do NOT explain your answer

---
${_textController.text.trim()}
''',
                              );
                              _textController.clear();
                            }
                          }
                        : null,
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

  bool _isPossibleChatInputMode() => _progress >= 100 && _isPossibleChatInput;

  Future<void> _sendMessage(String message) async {
    final gemmaInstance = FlutterGemmaPlugin.instance;
    setState(() {
      _isPossibleChatInput = false;
      _gemmaMessages.add(Message(text: message, isUser: true));
    });
    _jumpToEndMessage();

    final response = await gemmaInstance.getChatResponse(
      messages: _gemmaMessages, // TODO: 처음 튜닝 메세지와, 마지막 입력 메세지만 들어가도록 함
    );
    setState(() {
      _gemmaMessages
          .add(Message(text: response ?? 'AI response something wrong 🥲'));
      _isPossibleChatInput = true;
    });
    _jumpToEndMessage();
    debugPrint(_gemmaMessages.toString());
  }
}
