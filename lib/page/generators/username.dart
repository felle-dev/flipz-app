import 'package:flutter/material.dart';
import 'package:flipz/controllers/username_generator_controller.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';
import 'package:flipz/config/username_constants.dart';
import 'package:flipz/utils/clipboard_helper.dart';
import 'package:flipz/widgets/generated_result_card.dart';
import 'package:flipz/widgets/generator_options_card.dart';
import 'package:flipz/widgets/generation_history_card.dart';

class UsernameGeneratorPage extends StatefulWidget {
  const UsernameGeneratorPage({super.key});

  @override
  State<UsernameGeneratorPage> createState() => _UsernameGeneratorPageState();
}

class _UsernameGeneratorPageState extends State<UsernameGeneratorPage> {
  final UsernameGeneratorController _controller = UsernameGeneratorController();

  String _generatedUsername = '';
  bool _includeNumbers = true;
  bool _includeAdjective = true;
  bool _capitalize = true;
  String _separator = '';
  final List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _generateUsername();
  }

  void _generateUsername() {
    final username = _controller.generateUsername(
      includeAdjective: _includeAdjective,
      includeNumbers: _includeNumbers,
      capitalize: _capitalize,
      separator: _separator,
    );

    setState(() {
      _generatedUsername = username;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(username);
    });
  }

  void _copyToClipboard(String text) {
    ClipboardHelper.copyToClipboard(
      context,
      text,
      message: '${AppStrings.copied} "$text" ${AppStrings.copiedToClipboard}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.usernameGeneratorTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        children: [
          GeneratedResultCard(
            title: AppStrings.generatedUsername,
            result: _generatedUsername,
            icon: Icons.person_outline,
            onCopy: () => _copyToClipboard(_generatedUsername),
            onGenerate: _generateUsername,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          GeneratorOptionsCard(
            includeAdjective: _includeAdjective,
            includeNumbers: _includeNumbers,
            capitalize: _capitalize,
            separator: _separator,
            separators: UsernameConstants.separators,
            onAdjectiveChanged: (value) {
              setState(() => _includeAdjective = value);
              _generateUsername();
            },
            onNumbersChanged: (value) {
              setState(() => _includeNumbers = value);
              _generateUsername();
            },
            onCapitalizeChanged: (value) {
              setState(() => _capitalize = value);
              _generateUsername();
            },
            onSeparatorChanged: (value) {
              setState(() => _separator = value);
              _generateUsername();
            },
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          GenerationHistoryCard(
            history: _history,
            onClear: () => setState(() => _history.clear()),
            onCopy: _copyToClipboard,
            iconData: Icons.person,
          ),
          const SizedBox(height: AppDimensions.spacing100),
        ],
      ),
    );
  }
}
