import 'package:flutter/material.dart';
import 'package:flipz/config/app_strings.dart';

class DisclaimerDialog extends StatelessWidget {
  final VoidCallback onAgree;

  const DisclaimerDialog({super.key, required this.onAgree});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: Icon(
        Icons.warning_amber_rounded,
        color: theme.colorScheme.error,
        size: 48,
      ),
      title: Text(AppStrings.legalDisclaimer),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.disclaimerText1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.disclaimerWarning,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• Identity theft or fraud'),
            const Text('• Opening bank accounts'),
            const Text('• Applying for credit cards or loans'),
            const Text('• Creating fake social media profiles'),
            const Text('• Any form of impersonation'),
            const Text('• Evading legal obligations'),
            const Text('• Any other illegal activities'),
            const SizedBox(height: 16),
            Text(
              AppStrings.disclaimerLegalUses,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• Software testing and development'),
            const Text('• Database population for demos'),
            const Text('• Educational purposes'),
            const Text('• Privacy protection in examples'),
            const SizedBox(height: 16),
            Text(
              AppStrings.disclaimerAgreement,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onAgree();
          },
          child: Text(AppStrings.iAgree),
        ),
      ],
    );
  }
}
