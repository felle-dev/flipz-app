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

  final Map<String, Map<String, dynamic>> _countries = {
    'US': {
      'name': 'United States',
      'code': '+1',
      'flag': '🇺🇸',
      'format': '(###) ###-####',
      'example': '(555) 123-4567',
    },
    'UK': {
      'name': 'United Kingdom',
      'code': '+44',
      'flag': '🇬🇧',
      'format': '#### ### ####',
      'example': '7700 900123',
    },
    'CA': {
      'name': 'Canada',
      'code': '+1',
      'flag': '🇨🇦',
      'format': '(###) ###-####',
      'example': '(555) 123-4567',
    },
    'AU': {
      'name': 'Australia',
      'code': '+61',
      'flag': '🇦🇺',
      'format': '#### ### ###',
      'example': '0412 345 678',
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
      'format': '## ## ## ## ##',
      'example': '06 12 34 56 78',
    },
    'IT': {
      'name': 'Italy',
      'code': '+39',
      'flag': '🇮🇹',
      'format': '### ### ####',
      'example': '320 123 4567',
    },
    'ES': {
      'name': 'Spain',
      'code': '+34',
      'flag': '🇪🇸',
      'format': '### ## ## ##',
      'example': '612 34 56 78',
    },
    'NL': {
      'name': 'Netherlands',
      'code': '+31',
      'flag': '🇳🇱',
      'format': '## ########',
      'example': '06 12345678',
    },
    'JP': {
      'name': 'Japan',
      'code': '+81',
      'flag': '🇯🇵',
      'format': '###-####-####',
      'example': '090-1234-5678',
    },
    'CN': {
      'name': 'China',
      'code': '+86',
      'flag': '🇨🇳',
      'format': '### #### ####',
      'example': '138 0013 8000',
    },
    'IN': {
      'name': 'India',
      'code': '+91',
      'flag': '🇮🇳',
      'format': '##### #####',
      'example': '98765 43210',
    },
    'BR': {
      'name': 'Brazil',
      'code': '+55',
      'flag': '🇧🇷',
      'format': '(##) #####-####',
      'example': '(11) 98765-4321',
    },
    'MX': {
      'name': 'Mexico',
      'code': '+52',
      'flag': '🇲🇽',
      'format': '### ### ####',
      'example': '55 1234 5678',
    },
    'RU': {
      'name': 'Russia',
      'code': '+7',
      'flag': '🇷🇺',
      'format': '(###) ###-##-##',
      'example': '(912) 345-67-89',
    },
    'ZA': {
      'name': 'South Africa',
      'code': '+27',
      'flag': '🇿🇦',
      'format': '### ### ####',
      'example': '071 234 5678',
    },
    'KR': {
      'name': 'South Korea',
      'code': '+82',
      'flag': '🇰🇷',
      'format': '###-####-####',
      'example': '010-1234-5678',
    },
    'SE': {
      'name': 'Sweden',
      'code': '+46',
      'flag': '🇸🇪',
      'format': '###-### ## ##',
      'example': '070-123 45 67',
    },
    'NO': {
      'name': 'Norway',
      'code': '+47',
      'flag': '🇳🇴',
      'format': '### ## ###',
      'example': '412 34 567',
    },
    'PL': {
      'name': 'Poland',
      'code': '+48',
      'flag': '🇵🇱',
      'format': '### ### ###',
      'example': '512 345 678',
    },
    'RO': {
      'name': 'Romania',
      'code': '+40',
      'flag': '🇷🇴',
      'format': '#### ### ###',
      'example': '0712 345 678',
    },
    'ID': {
      'name': 'Indonesia',
      'code': '+62',
      'flag': '🇮🇩',
      'format': '####-####-####',
      'example': '0812-3456-7890',
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
    });
  }

  void _copyPhone() {
    Clipboard.setData(ClipboardData(text: _phoneFormat));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone number copied!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _copyPhoneOnly() {
    Clipboard.setData(ClipboardData(text: _generatedPhone));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phone number copied (without country code)!'),
        duration: Duration(seconds: 1),
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
          // Generated Phone Display
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
                  padding: const EdgeInsets.all(24),
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
                      const SizedBox(height: 24),

                      // Full Phone Number with Country Code
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withOpacity(
                            0.3,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                _phoneFormat,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  letterSpacing: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _copyPhoneOnly,
                              icon: const Icon(Icons.copy, size: 18),
                              label: const Text('Copy Number'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: _copyPhone,
                              icon: const Icon(Icons.copy_all, size: 18),
                              label: const Text('Copy with Code'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
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

          // Country Selection
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
                ..._countries.entries.map((entry) {
                  final isSelected = _selectedCountry == entry.key;
                  return Column(
                    children: [
                      ListTile(
                        leading: Text(
                          entry.value['flag'],
                          style: const TextStyle(fontSize: 28),
                        ),
                        title: Text(
                          entry.value['name'],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${entry.value['code']} ${entry.value['example']}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        trailing: Radio<String>(
                          value: entry.key,
                          groupValue: _selectedCountry,
                          onChanged: (value) {
                            setState(() {
                              _selectedCountry = value!;
                            });
                            _generatePhone();
                          },
                        ),
                        onTap: () {
                          setState(() {
                            _selectedCountry = entry.key;
                          });
                          _generatePhone();
                        },
                        selected: isSelected,
                        selectedTileColor: theme.colorScheme.primaryContainer
                            .withOpacity(0.2),
                      ),
                      if (entry.key != _countries.entries.last.key)
                        Divider(
                          height: 1,
                          indent: 72,
                          endIndent: 16,
                          color: theme.colorScheme.outlineVariant,
                        ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Generate Button
          FilledButton.icon(
            onPressed: _generatePhone,
            icon: const Icon(Icons.refresh),
            label: const Text('Generate New Number'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
          const SizedBox(height: 8),

          // Info Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.colorScheme.outlineVariant),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'These are randomly generated fake phone numbers for testing purposes only.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
