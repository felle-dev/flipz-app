import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class EmailGeneratorPage extends StatefulWidget {
  const EmailGeneratorPage({super.key});

  @override
  State<EmailGeneratorPage> createState() => _EmailGeneratorPageState();
}

class _EmailGeneratorPageState extends State<EmailGeneratorPage> {
  String _generatedEmail = '';
  bool _includeNumbers = true;
  bool _includeAdjective = true;
  bool _capitalize = false;
  String _separator = '.';
  String _domain = '@gmail.com';
  final List<String> _history = [];

  final List<String> _adjectives = [
    'the',
    'my',
    'this',
    'that',
    'some',
    'one',
    'two',
    'next',
    'last',
    'main',
    'real',
    'same',
    'other',
    'first',
    'second',
    'third',
    'full',
    'half',
    'whole',
    'each',
    'every',
    'any',
    'such',
    'own',
    'both',
    'few',
    'many',
    'most',
    'more',
    'less',
    'much',
    'little',
    'just',
    'only',
    'very',
  ];

  final List<String> _nouns = [
    'thing',
    'stuff',
    'item',
    'object',
    'element',
    'part',
    'piece',
    'unit',
    'place',
    'point',
    'case',
    'fact',
    'example',
    'instance',
    'sample',
    'data',
    'info',
    'detail',
    'aspect',
    'feature',
    'option',
    'choice',
    'type',
    'kind',
    'sort',
    'form',
    'way',
    'means',
    'method',
    'mode',
    'plan',
    'idea',
    'view',
    'area',
    'field',
    'topic',
    'subject',
    'matter',
    'issue',
    'question',
    'answer',
    'result',
    'outcome',
  ];

  final List<String> _separators = ['', '.', '_', '-'];

  final List<String> _domains = [
    '@gmail.com',
    '@yahoo.com',
    '@outlook.com',
    '@hotmail.com',
    '@proton.me',
    '@icloud.com',
    '@aol.com',
    '@mail.com',
    '@zoho.com',
    '@yandex.com',
    '@gmx.com',
    '@fastmail.com',
    '@tutanota.com',
    '@protonmail.com',
    '@inbox.com',
    '@live.com',
    '@msn.com',
    '@me.com',
    '@mac.com',
    '@hey.com',
  ];

  @override
  void initState() {
    super.initState();
    _generateEmail();
  }

  void _generateEmail() {
    final random = Random();
    String localPart = '';

    if (_includeAdjective) {
      String adjective = _adjectives[random.nextInt(_adjectives.length)];
      if (_capitalize) {
        adjective = adjective[0].toUpperCase() + adjective.substring(1);
      }
      localPart += adjective;
    }

    if (_includeAdjective && localPart.isNotEmpty) {
      localPart += _separator;
    }

    String noun = _nouns[random.nextInt(_nouns.length)];
    if (_capitalize) {
      noun = noun[0].toUpperCase() + noun.substring(1);
    }
    localPart += noun;

    if (_includeNumbers) {
      localPart += _separator;
      localPart += (random.nextInt(9000) + 1000).toString();
    }

    String email = localPart + _domain;

    setState(() {
      _generatedEmail = email;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(email);
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied "$text" to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Email Generator')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Generated Email Section
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
                        Icons.email_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Generated Email',
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
                      SelectableText(
                        _generatedEmail,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _copyToClipboard(_generatedEmail),
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
                            onPressed: _generateEmail,
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
                SwitchListTile(
                  title: const Text('Include Adjective'),
                  subtitle: const Text('Add descriptive word'),
                  value: _includeAdjective,
                  onChanged: (value) {
                    setState(() {
                      _includeAdjective = value;
                    });
                    _generateEmail();
                  },
                ),
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: theme.colorScheme.outlineVariant,
                ),
                SwitchListTile(
                  title: const Text('Include Numbers'),
                  subtitle: const Text('Add random numbers'),
                  value: _includeNumbers,
                  onChanged: (value) {
                    setState(() {
                      _includeNumbers = value;
                    });
                    _generateEmail();
                  },
                ),
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: theme.colorScheme.outlineVariant,
                ),
                SwitchListTile(
                  title: const Text('Capitalize'),
                  subtitle: const Text('Use capital letters'),
                  value: _capitalize,
                  onChanged: (value) {
                    setState(() {
                      _capitalize = value;
                    });
                    _generateEmail();
                  },
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Separator', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: _separators.map((sep) {
                          return ChoiceChip(
                            label: Text(sep.isEmpty ? 'None' : sep),
                            selected: _separator == sep,
                            onSelected: (selected) {
                              setState(() {
                                _separator = sep;
                              });
                              _generateEmail();
                            },
                          );
                        }).toList(),
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
                      Text('Email Domain', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _domains.map((domain) {
                          return ChoiceChip(
                            label: Text(domain),
                            selected: _domain == domain,
                            onSelected: (selected) {
                              setState(() {
                                _domain = domain;
                              });
                              _generateEmail();
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
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
                  ..._history.reversed.map((email) {
                    final isLast = email == _history.reversed.last;
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.email,
                                size: 20,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            title: Text(
                              email,
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () => _copyToClipboard(email),
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
