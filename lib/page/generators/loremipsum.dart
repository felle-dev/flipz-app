import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class LoremIpsumGeneratorPage extends StatefulWidget {
  const LoremIpsumGeneratorPage({super.key});

  @override
  State<LoremIpsumGeneratorPage> createState() =>
      _LoremIpsumGeneratorPageState();
}

class _LoremIpsumGeneratorPageState extends State<LoremIpsumGeneratorPage> {
  String _generatedText = '';
  String _generationType = 'paragraphs';
  int _count = 3;
  bool _startWithLorem = true;
  final List<String> _history = [];

  final List<String> _words = [
    'lorem',
    'ipsum',
    'dolor',
    'sit',
    'amet',
    'consectetur',
    'adipiscing',
    'elit',
    'sed',
    'do',
    'eiusmod',
    'tempor',
    'incididunt',
    'ut',
    'labore',
    'et',
    'dolore',
    'magna',
    'aliqua',
    'enim',
    'ad',
    'minim',
    'veniam',
    'quis',
    'nostrud',
    'exercitation',
    'ullamco',
    'laboris',
    'nisi',
    'aliquip',
    'ex',
    'ea',
    'commodo',
    'consequat',
    'duis',
    'aute',
    'irure',
    'in',
    'reprehenderit',
    'voluptate',
    'velit',
    'esse',
    'cillum',
    'fugiat',
    'nulla',
    'pariatur',
    'excepteur',
    'sint',
    'occaecat',
    'cupidatat',
    'non',
    'proident',
    'sunt',
    'culpa',
    'qui',
    'officia',
    'deserunt',
    'mollit',
    'anim',
    'id',
    'est',
    'laborum',
  ];

  @override
  void initState() {
    super.initState();
    _generateText();
  }

  String _generateSentence({bool startWithLorem = false}) {
    final random = Random();
    final length = random.nextInt(8) + 8; // 8-15 words per sentence
    final words = <String>[];

    if (startWithLorem) {
      words.add('Lorem');
      words.add('ipsum');
      words.add('dolor');
      words.add('sit');
      words.add('amet');
    }

    while (words.length < length) {
      words.add(_words[random.nextInt(_words.length)]);
    }

    // Capitalize first letter
    words[0] = words[0][0].toUpperCase() + words[0].substring(1);

    return '${words.join(' ')}.';
  }

  String _generateParagraph({bool startWithLorem = false}) {
    final random = Random();
    final sentenceCount = random.nextInt(3) + 3; // 3-5 sentences per paragraph
    final sentences = <String>[];

    for (int i = 0; i < sentenceCount; i++) {
      sentences.add(
        _generateSentence(
          startWithLorem: startWithLorem && i == 0 && sentences.isEmpty,
        ),
      );
    }

    return sentences.join(' ');
  }

  void _generateText() {
    final random = Random();
    String result = '';

    switch (_generationType) {
      case 'words':
        final words = <String>[];
        if (_startWithLorem) {
          words.addAll(['Lorem', 'ipsum', 'dolor', 'sit', 'amet']);
        }
        while (words.length < _count) {
          words.add(_words[random.nextInt(_words.length)]);
        }
        result = words.take(_count).join(' ');
        break;

      case 'sentences':
        final sentences = <String>[];
        for (int i = 0; i < _count; i++) {
          sentences.add(
            _generateSentence(startWithLorem: _startWithLorem && i == 0),
          );
        }
        result = sentences.join(' ');
        break;

      case 'paragraphs':
        final paragraphs = <String>[];
        for (int i = 0; i < _count; i++) {
          paragraphs.add(
            _generateParagraph(startWithLorem: _startWithLorem && i == 0),
          );
        }
        result = paragraphs.join('\n\n');
        break;
    }

    setState(() {
      _generatedText = result;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(result);
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Lorem Ipsum Generator')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Generated Text Section
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.text_fields,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Generated Text',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        child: SingleChildScrollView(
                          child: SelectableText(
                            _generatedText,
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _copyToClipboard(_generatedText),
                            icon: const Icon(Icons.copy),
                            label: const Text('Copy'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          FilledButton.tonalIcon(
                            onPressed: _generateText,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Generate'),
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Options Section
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.tune_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Options',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Type', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          ChoiceChip(
                            label: const Text('Words'),
                            selected: _generationType == 'words',
                            onSelected: (selected) {
                              setState(() {
                                _generationType = 'words';
                                if (_count > 50) _count = 50;
                              });
                              _generateText();
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Sentences'),
                            selected: _generationType == 'sentences',
                            onSelected: (selected) {
                              setState(() {
                                _generationType = 'sentences';
                                if (_count > 20) _count = 20;
                              });
                              _generateText();
                            },
                          ),
                          ChoiceChip(
                            label: const Text('Paragraphs'),
                            selected: _generationType == 'paragraphs',
                            onSelected: (selected) {
                              setState(() {
                                _generationType = 'paragraphs';
                                if (_count > 10) _count = 10;
                              });
                              _generateText();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Count', style: theme.textTheme.titleMedium),
                          Text(
                            _count.toString(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Slider(
                        value: _count.toDouble(),
                        min: 1,
                        max: _generationType == 'words'
                            ? 100
                            : _generationType == 'sentences'
                            ? 20
                            : 10,
                        divisions: _generationType == 'words'
                            ? 99
                            : _generationType == 'sentences'
                            ? 19
                            : 9,
                        label: _count.toString(),
                        onChanged: (value) {
                          setState(() {
                            _count = value.round();
                          });
                        },
                        onChangeEnd: (value) {
                          _generateText();
                        },
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                SwitchListTile(
                  title: const Text('Start with "Lorem ipsum"'),
                  subtitle: const Text('Begin with classic phrase'),
                  value: _startWithLorem,
                  onChanged: (value) {
                    setState(() {
                      _startWithLorem = value;
                    });
                    _generateText();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // History Section
          if (_history.isNotEmpty)
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
                color: theme.colorScheme.surface,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Recent History',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _history.clear();
                            });
                          },
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: theme.colorScheme.outlineVariant),
                  ..._history.reversed.map((text) {
                    final isLast = text == _history.reversed.last;
                    final preview = text.length > 100
                        ? '${text.substring(0, 100)}...'
                        : text;
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.text_snippet,
                                size: 20,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            title: Text(
                              preview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () => _copyToClipboard(text),
                            ),
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            indent: 72,
                            color: theme.colorScheme.outlineVariant,
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
