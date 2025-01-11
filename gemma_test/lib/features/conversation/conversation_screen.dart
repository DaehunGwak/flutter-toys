import 'package:flutter/material.dart';
import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:gemma_test/features/conversation/widget/message_widget.dart';

const _firstMessage = Message(
  text: '앞으로 입력하는 할일 내용에 대해서 아이들도 수행하기 쉽도록 잘게 쪼개주는데 '
      'json list 형식으로 응답해줘.'
      '예를 들어 "앱 개발하기" 가 입력되면, '
      '"["플랫폼 선정", "개발 언어 설정", "의도, 기획 설정", "메인 기능 기획"]" 으로 대답해. '
      '다른 이야기는 할 필요 없어.',
  isUser: true,
);

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key, required this.title});

  final String title;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  final List<Message> _gemmaMessages = [_firstMessage];

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
        await FlutterGemmaPlugin.instance.init();
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
                _gemmaMessages.add(_firstMessage);
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
                              _sendMessage(_textController.text.trim());
                              _textController.clear();
                              _jumpToEndMessage();
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
    final response =
        await gemmaInstance.getChatResponse(messages: _gemmaMessages);
    setState(() {
      _gemmaMessages
          .add(Message(text: response ?? 'AI response something wrong 🥲'));
      _isPossibleChatInput = true;
    });
    debugPrint(_gemmaMessages.toString());
  }
}
