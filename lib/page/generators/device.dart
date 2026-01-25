import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class DeviceGeneratorPage extends StatefulWidget {
  const DeviceGeneratorPage({super.key});

  @override
  State<DeviceGeneratorPage> createState() => _DeviceGeneratorPageState();
}

class _DeviceGeneratorPageState extends State<DeviceGeneratorPage> {
  String _generatedDeviceName = '';
  String _selectedCategory = 'Random';
  final List<String> _history = [];

  // Realistic naming patterns
  final Map<String, List<String>> _namePatterns = {
    'Samsung': [
      'Galaxy_####',
      'SM-####',
      'GalaxyS##',
      'GalaxyA##',
      'SM-A###',
      'SM-G###',
      'Galaxy A##',
      'Galaxy S##',
      'Galaxy M##',
      'Galaxy F##',
      'AndroidAP_####',
    ],
    'Xiaomi': [
      'Xiaomi_####',
      'Redmi_####',
      'POCO_####',
      'Mi_####',
      'Redmi Note ##',
      'POCO X#',
      'POCO F#',
      'POCO M#',
      'Redmi ##',
      'Mi ##',
      'AndroidAP_####',
    ],
    'Oppo': [
      'OPPO_####',
      'CPH####',
      'OPPO A##',
      'OPPO Reno#',
      'OPPO Find X#',
      'CPH###',
      'AndroidAP_####',
    ],
    'Vivo': [
      'vivo_####',
      'vivo Y##',
      'vivo V##',
      'vivo X##',
      'iQOO_####',
      'iQOO ##',
      'AndroidAP_####',
    ],
    'Realme': [
      'realme_####',
      'RMX####',
      'realme ##',
      'realme C##',
      'realme GT#',
      'Narzo ##',
      'AndroidAP_####',
    ],
    'Huawei': [
      'HUAWEI_####',
      'HUAWEI-####',
      'HUAWEI P##',
      'HUAWEI Y#',
      'HONOR_####',
      'HONOR ##',
      'AndroidAP_####',
    ],
    'iPhone': [
      'iPhone_####',
      "iPhone's iPhone",
      'iPhone (##)',
      'My iPhone',
      'iPhone',
    ],
    'Router': [
      'NETGEAR##',
      'NETGEAR####',
      'ASUS_####',
      'ASUS##',
      'TP-Link_####',
      'TPLink####',
      'Linksys####',
      'Linksys_####',
      'D-Link_####',
      'DLink####',
      'Wireless_####',
      'Router_####',
      'Network_####',
      'Home_WiFi_####',
      'Tenda_####',
      'Tenda##',
      'Mercusys_####',
      'ZTE_####',
      'ZTE####',
      'Huawei_####',
      'HuaweiWiFi_####',
      'Belkin_####',
      'Belkin##',
      'Cisco_####',
      'Arris_####',
      'Motorola_####',
      'Ubiquiti_####',
      'MikroTik_####',
      'Synology_####',
      'Buffalo_####',
      'AirPort_####',
      'Archer_####',
      'Archer##',
      'Deco_####',
      'Mesh_####',
      'SmartWiFi_####',
      'HomeNet_####',
      'MyNetwork_####',
      'WiFi_####',
      'Net_####',
    ],
  };

  @override
  void initState() {
    super.initState();
    _generateDeviceName();
  }

  String _generateNumber(String pattern) {
    final random = Random();
    return pattern.replaceAllMapped(RegExp(r'#'), (match) {
      return random.nextInt(10).toString();
    });
  }

  void _generateDeviceName() {
    final random = Random();
    String deviceName = '';

    String selectedCategory = _selectedCategory;

    if (_selectedCategory == 'Random') {
      final categories = _namePatterns.keys.toList();
      selectedCategory = categories[random.nextInt(categories.length)];
    }

    final patterns = _namePatterns[selectedCategory]!;
    final pattern = patterns[random.nextInt(patterns.length)];

    deviceName = _generateNumber(pattern);

    setState(() {
      _generatedDeviceName = deviceName;
      if (_history.length >= 10) {
        _history.removeAt(0);
      }
      _history.add(deviceName);
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
    final categories = ['Random', ..._namePatterns.keys.toList()];

    return Scaffold(
      appBar: AppBar(title: const Text('WiFi Name Generator')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Generated Name Section
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
                        Icons.wifi,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Generated WiFi Name',
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
                        _generatedDeviceName,
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
                            onPressed: () =>
                                _copyToClipboard(_generatedDeviceName),
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
                            onPressed: _generateDeviceName,
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

          // Category Selection Section
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
                        'Select Category',
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
                    children: categories.map((category) {
                      return ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategory = category;
                          });
                          _generateDeviceName();
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
                  ..._history.reversed.map((deviceName) {
                    final isLast = deviceName == _history.reversed.last;
                    return Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              child: Icon(
                                Icons.wifi,
                                size: 20,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                            title: Text(
                              deviceName,
                              style: const TextStyle(fontFamily: 'monospace'),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () => _copyToClipboard(deviceName),
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
