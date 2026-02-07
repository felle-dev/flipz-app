import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flipz/controllers/identity_generator_controller.dart';
import 'package:flipz/config/app_strings.dart';
import 'package:flipz/config/app_dimensions.dart';
import 'package:flipz/widgets/disclaimer_dialog.dart';

class RandomIdentityGeneratorPage extends StatefulWidget {
  const RandomIdentityGeneratorPage({super.key});

  @override
  State<RandomIdentityGeneratorPage> createState() =>
      _RandomIdentityGeneratorPageState();
}

class _RandomIdentityGeneratorPageState
    extends State<RandomIdentityGeneratorPage> {
  final IdentityGeneratorController _controller = IdentityGeneratorController();

  Map<String, String> _identity = {};
  String _selectedGender = AppStrings.random;
  String _selectedCountry = AppStrings.countryUS;
  bool _hasAgreedToTerms = false;

  void _generateIdentity() {
    if (!_hasAgreedToTerms) {
      _showDisclaimerDialog();
      return;
    }

    final identityData = _controller.generateIdentity(
      _selectedCountry,
      _selectedGender,
    );

    setState(() {
      _identity = identityData.toMap();
    });
  }

  void _showDisclaimerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DisclaimerDialog(
          onAgree: () {
            setState(() {
              _hasAgreedToTerms = true;
            });
            _generateIdentity();
          },
        );
      },
    );
  }

  void _copyField(String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${AppStrings.copied}: $value'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _copyAll() {
    final allData = _identity.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');
    Clipboard.setData(ClipboardData(text: allData));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(AppStrings.allDataCopied)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.identityGeneratorTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        children: [
          // Legal Warning Banner
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSmall + 4,
              ),
              border: Border.all(color: theme.colorScheme.error, width: 2),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: theme.colorScheme.error,
                  size: AppDimensions.iconMedium,
                ),
                const SizedBox(width: AppDimensions.spacing12),
                Expanded(
                  child: Text(
                    AppStrings.legalWarning,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Settings Section
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  child: Row(
                    children: [
                      Icon(
                        Icons.tune_outlined,
                        color: theme.colorScheme.primary,
                        size: AppDimensions.iconMedium,
                      ),
                      const SizedBox(width: AppDimensions.spacing8),
                      Text(
                        AppStrings.settings,
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
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.country,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppDimensions.spacing8),
                      SegmentedButton<String>(
                        segments: [
                          ButtonSegment(
                            value: AppStrings.countryUS,
                            label: Text('🇺🇸 US'),
                          ),
                          ButtonSegment(
                            value: AppStrings.countryGermany,
                            label: Text('🇩🇪 DE'),
                          ),
                          ButtonSegment(
                            value: AppStrings.countryIndonesia,
                            label: Text('🇮🇩 ID'),
                          ),
                        ],
                        selected: {_selectedCountry},
                        onSelectionChanged: (Set<String> newSelection) {
                          setState(() {
                            _selectedCountry = newSelection.first;
                          });
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingLarge),
                      Text(
                        AppStrings.gender,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppDimensions.spacing8),
                      SegmentedButton<String>(
                        segments:  [
                          ButtonSegment(
                            value: AppStrings.random,
                            label: Text(AppStrings.random),
                            icon: Icon(Icons.shuffle, size: 16),
                          ),
                          ButtonSegment(
                            value: AppStrings.male,
                            label: Text(AppStrings.male),
                            icon: Icon(Icons.male, size: 16),
                          ),
                          ButtonSegment(
                            value: AppStrings.female,
                            label: Text(AppStrings.female),
                            icon: Icon(Icons.female, size: 16),
                          ),
                        ],
                        selected: {_selectedGender},
                        onSelectionChanged: (Set<String> newSelection) {
                          setState(() {
                            _selectedGender = newSelection.first;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Generate Button
          FilledButton.icon(
            onPressed: _generateIdentity,
            icon: const Icon(Icons.refresh),
            label: Text(AppStrings.generateIdentity),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: AppDimensions.paddingMedium,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Generated Identity Section
          if (_identity.isNotEmpty) ...[
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                color: theme.colorScheme.surface,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: theme.colorScheme.primary,
                          size: AppDimensions.iconMedium,
                        ),
                        const SizedBox(width: AppDimensions.spacing8),
                        Text(
                          AppStrings.generatedIdentity,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.copy_all,
                            size: AppDimensions.iconMedium,
                          ),
                          onPressed: _copyAll,
                          tooltip: AppStrings.copyAll,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: theme.colorScheme.outlineVariant),
                  ..._identity.entries.map((entry) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            entry.key,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimensions.paddingXSmall,
                            ),
                            child: Text(
                              entry.value,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontFamily: _shouldUseMonospace(entry.key)
                                    ? 'monospace'
                                    : null,
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.copy,
                              size: AppDimensions.iconSmall,
                            ),
                            onPressed: () => _copyField(entry.value),
                          ),
                        ),
                        if (entry.key != _identity.entries.last.key)
                          Divider(
                            height: 1,
                            indent: AppDimensions.paddingMedium,
                            endIndent: AppDimensions.paddingMedium,
                            color: theme.colorScheme.outlineVariant,
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppDimensions.spacing100),
        ],
      ),
    );
  }

  bool _shouldUseMonospace(String key) {
    const monospaceKeys = [
      'Email',
      'Username',
      'SSN',
      'NIK',
      'ID Number',
      'NPWP',
      'Tax ID',
      'IBAN',
      'Credit Card',
      'CVV',
      'Card Exp',
    ];
    return monospaceKeys.contains(key);
  }
}
