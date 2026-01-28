import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneGeneratorPage extends StatefulWidget {
  const PhoneGeneratorPage({super.key});

  @override
  State<PhoneGeneratorPage> createState() => _PhoneGeneratorPageState();
}

class _PhoneGeneratorPageState extends State<PhoneGeneratorPage> {
  String _generatedPhone = '';
  String _selectedCountry = 'US';
  String _phoneFormat = '';
  final List<Map<String, String>> _history = [];

  final Map<String, Map<String, dynamic>> _countries = {
    'US': {
      'name': 'United States',
      'code': '+1',
      'flag': '🇺🇸',
      'format': '(###) ###-####',
      'example': '(555) 123-4567',
    },
    'GB': {
      'name': 'United Kingdom',
      'code': '+44',
      'flag': '🇬🇧',
      'format': '#### ### ####',
      'example': '7700 900123',
    },
    'DE': {
      'name': 'Germany',
      'code': '+49',
      'flag': '🇩🇪',
      'format': '#### ########',
      'example': '0151 23456789',
    },
    'FR': {
      'name': 'France',
      'code': '+33',
      'flag': '🇫🇷',
      'format': '# ## ## ## ##',
      'example': '6 12 34 56 78',
    },
    'ID': {
      'name': 'Indonesia',
      'code': '+62',
      'flag': '🇮🇩',
      'format': '8##-####-####',
      'example': '812-3456-7890',
    },
    'JP': {
      'name': 'Japan',
      'code': '+81',
      'flag': '🇯🇵',
      'format': '##-####-####',
      'example': '90-1234-5678',
    },
    'AU': {
      'name': 'Australia',
      'code': '+61',
      'flag': '🇦🇺',
      'format': '#### ### ###',
      'example': '0412 345 678',
    },
    'CA': {
      'name': 'Canada',
      'code': '+1',
      'flag': '🇨🇦',
      'format': '(###) ###-####',
      'example': '(416) 555-0123',
    },
  };

  @override
  void initState() {
    super.initState();
    _generatePhone();
  }

  void _generatePhone() {
    final random = Random();
    final country = _countries[_selectedCountry]!;
    final format = country['format'] as String;

    String phone = format;
    for (int i = 0; i < phone.length; i++) {
      if (phone[i] == '#') {
        phone = phone.replaceFirst('#', random.nextInt(10).toString());
      }
    }

    setState(() {
      _generatedPhone = phone;
      _phoneFormat = '${country['code']} $phone';
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add({
        'number': phone,
        'full': _phoneFormat,
        'flag': country['flag'],
        'country': country['name'],
      });
    });
  }

  void _copyToClipboard(String text, {bool withCode = false}) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          withCode ? 'Copied with country code' : 'Copied without country code',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final country = _countries[_selectedCountry]!;

    return Scaffold(
      appBar: AppBar(title: const Text('Phone Generator')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Generated Phone Section
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
                        Icons.phone_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Generated Phone',
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
                      // Country Flag and Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            country['flag'],
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            country['name'],
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Full Phone Number with Country Code
                      SelectableText(
                        _phoneFormat,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () => _copyToClipboard(
                                _phoneFormat,
                                withCode: true,
                              ),
                              icon: const Icon(Icons.copy),
                              label: const Text('With Code'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.tonalIcon(
                              onPressed: _generatePhone,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Generate'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () => _copyToClipboard(_generatedPhone),
                        icon: const Icon(Icons.copy, size: 18),
                        label: const Text('Copy Without Code'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Country Selection Section
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
                        Icons.public,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Select Country',
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
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _countries.entries.map((entry) {
                      return ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              entry.value['flag'],
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 6),
                            Text(entry.value['name']),
                          ],
                        ),
                        selected: _selectedCountry == entry.key,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCountry = entry.key;
                          });
                          _generatePhone();
                        },
                      );
                    }).toList(),
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
                  ..._history.reversed.map((phone) {
                    final isLast = phone == _history.reversed.last;
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Text(
                                phone['flag']!,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            title: Text(
                              phone['full']!,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(phone['country']!),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () => _copyToClipboard(
                                phone['full']!,
                                withCode: true,
                              ),
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
