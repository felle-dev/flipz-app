import 'package:flutter/material.dart';
import 'package:flipz/controllers/email_generator_controller.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';
import 'package:flipz/config/email_constants.dart';
import 'package:flipz/utils/clipboard_helper.dart';
import 'package:flipz/widgets/generated_result_card.dart';
import 'package:flipz/widgets/email_options_card.dart';
import 'package:flipz/widgets/generation_history_card.dart';

class EmailGeneratorPage extends StatefulWidget {
  const EmailGeneratorPage({super.key});

  @override
  State<EmailGeneratorPage> createState() => _EmailGeneratorPageState();
}

class _EmailGeneratorPageState extends State<EmailGeneratorPage> {
  final EmailGeneratorController _controller = EmailGeneratorController();

  String _generatedEmail = '';
  bool _includeNumbers = true;
  bool _includeAdjective = true;
  bool _capitalize = false;
  String _separator = '.';
  String _domain = '@proton.me';
  final List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _generateEmail();
  }

  void _generateEmail() {
    final email = _controller.generateEmail(
      includeAdjective: _includeAdjective,
      includeNumbers: _includeNumbers,
      capitalize: _capitalize,
      separator: _separator,
      domain: _domain,
    );

    setState(() {
      _generatedEmail = email;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(email);
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
      appBar: AppBar(title: const Text(AppStrings.emailGeneratorTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        children: [
          GeneratedResultCard(
            title: AppStrings.generatedEmailTitle,
            result: _generatedEmail,
            icon: Icons.email_outlined,
            onCopy: () => _copyToClipboard(_generatedEmail),
            onGenerate: _generateEmail,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          EmailOptionsCard(
            includeAdjective: _includeAdjective,
            includeNumbers: _includeNumbers,
            capitalize: _capitalize,
            separator: _separator,
            domain: _domain,
            separators: EmailConstants.separators,
            domains: EmailConstants.domains,
            onAdjectiveChanged: (value) {
              setState(() => _includeAdjective = value);
              _generateEmail();
            },
            onNumbersChanged: (value) {
              setState(() => _includeNumbers = value);
              _generateEmail();
            },
            onCapitalizeChanged: (value) {
              setState(() => _capitalize = value);
              _generateEmail();
            },
            onSeparatorChanged: (value) {
              setState(() => _separator = value);
              _generateEmail();
            },
            onDomainChanged: (value) {
              setState(() => _domain = value);
              _generateEmail();
            },
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          GenerationHistoryCard(
            history: _history,
            onClear: () => setState(() => _history.clear()),
            onCopy: _copyToClipboard,
            iconData: Icons.email,
          ),
          const SizedBox(height: AppDimensions.spacing100),
        ],
      ),
    );
  }
}
