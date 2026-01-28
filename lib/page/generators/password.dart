import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key});

  @override
  State<PasswordGeneratorPage> createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  String _password = '';
  int _length = 16;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;
  final List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _generatePassword();
  }

  void _generatePassword() {
    const uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    String chars = '';
    if (_includeUppercase) chars += uppercase;
    if (_includeLowercase) chars += lowercase;
    if (_includeNumbers) chars += numbers;
    if (_includeSymbols) chars += symbols;

    if (chars.isEmpty) return;

    final random = Random.secure();
    final newPassword = List.generate(
      _length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();

    setState(() {
      _password = newPassword;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(newPassword);
    });
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied password to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _getStrengthLabel() {
    int strength = 0;
    if (_includeUppercase) strength++;
    if (_includeLowercase) strength++;
    if (_includeNumbers) strength++;
    if (_includeSymbols) strength++;

    if (_length >= 16 && strength >= 3) return 'Very Strong';
    if (_length >= 12 && strength >= 3) return 'Strong';
    if (_length >= 10 && strength >= 2) return 'Medium';
    return 'Weak';
  }

  Color _getStrengthColor(BuildContext context) {
    final strength = _getStrengthLabel();
    final colorScheme = Theme.of(context).colorScheme;

    switch (strength) {
      case 'Very Strong':
        return Colors.green;
      case 'Strong':
        return Colors.lightGreen;
      case 'Medium':
        return Colors.orange;
      default:
        return colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Password Generator')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Generated Password Section
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
                        Icons.lock_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Generated Password',
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
                        _password,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      // Strength Indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStrengthColor(context).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _getStrengthColor(context).withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.shield_outlined,
                              size: 16,
                              color: _getStrengthColor(context),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Strength: ${_getStrengthLabel()}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: _getStrengthColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _copyToClipboard(_password),
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
                            onPressed: _generatePassword,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Length', style: theme.textTheme.titleMedium),
                          Text(
                            _length.toString(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Slider(
                        value: _length.toDouble(),
                        min: 8,
                        max: 32,
                        divisions: 24,
                        label: _length.toString(),
                        onChanged: (value) {
                          setState(() {
                            _length = value.toInt();
                          });
                        },
                        onChangeEnd: (value) {
                          _generatePassword();
                        },
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: theme.colorScheme.outlineVariant),
                SwitchListTile(
                  title: const Text('Uppercase Letters (A-Z)'),
                  subtitle: const Text('Include capital letters'),
                  value: _includeUppercase,
                  onChanged: (value) {
                    setState(() {
                      _includeUppercase = value;
                    });
                    _generatePassword();
                  },
                ),
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: theme.colorScheme.outlineVariant,
                ),
                SwitchListTile(
                  title: const Text('Lowercase Letters (a-z)'),
                  subtitle: const Text('Include lowercase letters'),
                  value: _includeLowercase,
                  onChanged: (value) {
                    setState(() {
                      _includeLowercase = value;
                    });
                    _generatePassword();
                  },
                ),
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: theme.colorScheme.outlineVariant,
                ),
                SwitchListTile(
                  title: const Text('Numbers (0-9)'),
                  subtitle: const Text('Include numeric digits'),
                  value: _includeNumbers,
                  onChanged: (value) {
                    setState(() {
                      _includeNumbers = value;
                    });
                    _generatePassword();
                  },
                ),
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: theme.colorScheme.outlineVariant,
                ),
                SwitchListTile(
                  title: const Text('Symbols (!@#\$...)'),
                  subtitle: const Text('Include special characters'),
                  value: _includeSymbols,
                  onChanged: (value) {
                    setState(() {
                      _includeSymbols = value;
                    });
                    _generatePassword();
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
                  ..._history.reversed.map((password) {
                    final isLast = password == _history.reversed.last;
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.key,
                                size: 20,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            title: Text(
                              password,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                letterSpacing: 0.5,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () => _copyToClipboard(password),
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
