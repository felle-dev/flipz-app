import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class UsernameGeneratorPage extends StatefulWidget {
  const UsernameGeneratorPage({super.key});

  @override
  State<UsernameGeneratorPage> createState() => _UsernameGeneratorPageState();
}

class _UsernameGeneratorPageState extends State<UsernameGeneratorPage> {
  String _generatedUsername = '';
  bool _includeNumbers = true;
  bool _includeAdjective = true;
  bool _capitalize = true;
  String _separator = '';
  final List<String> _history = [];

  final List<String> _adjectives = [
    'Cool', 'Epic', 'Swift', 'Brave', 'Noble', 'Wise', 'Clever', 'Mighty',
    'Silent', 'Golden', 'Shadow', 'Mystic', 'Thunder', 'Crimson', 'Azure',
    'Cosmic', 'Stellar', 'Lunar', 'Solar', 'Wild', 'Free', 'Bold', 'Dark',
    'Bright', 'Quick', 'Super', 'Ultra', 'Mega', 'Alpha', 'Prime'
  ];

  final List<String> _nouns = [
    'Wolf', 'Eagle', 'Dragon', 'Phoenix', 'Tiger', 'Lion', 'Falcon', 'Hawk',
    'Bear', 'Panther', 'Knight', 'Warrior', 'Hunter', 'Ranger', 'Mage',
    'Ninja', 'Samurai', 'Viking', 'Titan', 'Legend', 'Hero', 'Champion',
    'Master', 'Wizard', 'Storm', 'Thunder', 'Blaze', 'Frost', 'Shadow', 'Star'
  ];

  final List<String> _separators = ['', '_', '-', '.'];

  @override
  void initState() {
    super.initState();
    _generateUsername();
  }

  void _generateUsername() {
    final random = Random();
    String username = '';

    if (_includeAdjective) {
      String adjective = _adjectives[random.nextInt(_adjectives.length)];
      if (!_capitalize) adjective = adjective.toLowerCase();
      username += adjective;
    }

    if (_includeAdjective && username.isNotEmpty) {
      username += _separator;
    }

    String noun = _nouns[random.nextInt(_nouns.length)];
    if (!_capitalize) noun = noun.toLowerCase();
    username += noun;

    if (_includeNumbers) {
      username += _separator;
      username += (random.nextInt(9000) + 1000).toString();
    }

    setState(() {
      _generatedUsername = username;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(username);
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
      appBar: AppBar(
        title: const Text('Username Generator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Generated username display
            Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'Generated Username',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SelectableText(
                      _generatedUsername,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        fontFamily: 'monospace',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton.icon(
                          onPressed: () => _copyToClipboard(_generatedUsername),
                          icon: const Icon(Icons.copy),
                          label: const Text('Copy'),
                        ),
                        const SizedBox(width: 12),
                        FilledButton.tonalIcon(
                          onPressed: _generateUsername,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Generate'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Options
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Options',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Include Adjective'),
                      subtitle: const Text('Add descriptive word'),
                      value: _includeAdjective,
                      onChanged: (value) {
                        setState(() {
                          _includeAdjective = value;
                        });
                        _generateUsername();
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Include Numbers'),
                      subtitle: const Text('Add random numbers'),
                      value: _includeNumbers,
                      onChanged: (value) {
                        setState(() {
                          _includeNumbers = value;
                        });
                        _generateUsername();
                      },
                    ),
                    SwitchListTile(
                      title: const Text('Capitalize'),
                      subtitle: const Text('Use capital letters'),
                      value: _capitalize,
                      onChanged: (value) {
                        setState(() {
                          _capitalize = value;
                        });
                        _generateUsername();
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Separator',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
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
                            _generateUsername();
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // History
            if (_history.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent History',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                      const SizedBox(height: 8),
                      ..._history.reversed.map((username) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 20,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          title: Text(
                            username,
                            style: const TextStyle(fontFamily: 'monospace'),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () => _copyToClipboard(username),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}