import 'package:flutter/material.dart';
import 'package:flipz/controllers/lorem_ipsum_controller.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';
import 'package:flipz/config/lorem_constants.dart';
import 'package:flipz/utils/clipboard_helper.dart';
import 'package:flipz/widgets/lorem_text_card.dart';
import 'package:flipz/widgets/lorem_options_card.dart';
import 'package:flipz/widgets/text_history_card.dart';

class LoremIpsumGeneratorPage extends StatefulWidget {
  const LoremIpsumGeneratorPage({super.key});

  @override
  State<LoremIpsumGeneratorPage> createState() =>
      _LoremIpsumGeneratorPageState();
}

class _LoremIpsumGeneratorPageState extends State<LoremIpsumGeneratorPage> {
  final LoremIpsumController _controller = LoremIpsumController();

  String _generatedText = '';
  String _generationType = LoremConstants.typeParagraphs;
  int _count = 3;
  bool _startWithLorem = true;
  final List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _generateText();
  }

  void _generateText() {
    final text = _controller.generateText(
      type: _generationType,
      count: _count,
      startWithLorem: _startWithLorem,
    );

    setState(() {
      _generatedText = text;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(text);
    });
  }

  void _copyToClipboard(String text) {
    ClipboardHelper.copyToClipboard(
      context,
      text,
      message: AppStrings.copiedToClipboard,
    );
  }

  void _onTypeChanged(String newType) {
    setState(() {
      _generationType = newType;
      final maxCount = _controller.getMaxCount(newType);
      if (_count > maxCount) {
        _count = maxCount;
      }
    });
    _generateText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.loremIpsumGeneratorTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        children: [
          LoremTextCard(
            text: _generatedText,
            onCopy: () => _copyToClipboard(_generatedText),
            onGenerate: _generateText,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          LoremOptionsCard(
            type: _generationType,
            count: _count,
            startWithLorem: _startWithLorem,
            maxCount: _controller.getMaxCount(_generationType),
            divisions: _controller.getDivisions(_generationType),
            onTypeChanged: _onTypeChanged,
            onCountChanged: (value) {
              setState(() => _count = value);
              _generateText();
            },
            onStartWithLoremChanged: (value) {
              setState(() => _startWithLorem = value);
              _generateText();
            },
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          TextHistoryCard(
            history: _history,
            onClear: () => setState(() => _history.clear()),
            onCopy: _copyToClipboard,
          ),
          const SizedBox(height: AppDimensions.spacing100),
        ],
      ),
    );
  }
}
