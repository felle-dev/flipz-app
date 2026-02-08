import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/random_number_constants.dart';
import '../../controllers/random_number_controller.dart';
import '../../widgets/number_result_card.dart';
import '../../widgets/number_range_settings_card.dart';

class RandomNumberPage extends StatefulWidget {
  const RandomNumberPage({super.key});

  @override
  State<RandomNumberPage> createState() => _RandomNumberPageState();
}

class _RandomNumberPageState extends State<RandomNumberPage> {
  late RandomNumberController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RandomNumberController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleGenerate() {
    final result = _controller.generate();

    if (!result.success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.randomNumberMinLessThanMax),
          duration: const Duration(
            seconds: RandomNumberConstants.snackbarDurationSeconds,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.randomNumberTitle)),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return ListView(
            padding: const EdgeInsets.all(RandomNumberConstants.paddingPage),
            children: [
              // Result Section
              if (_controller.hasResult) ...[
                NumberResultCard(result: _controller.result!),
                const SizedBox(height: RandomNumberConstants.spacing16),
              ],

              // Settings Section
              NumberRangeSettingsCard(
                minController: _controller.minController,
                maxController: _controller.maxController,
                onMinChanged: _controller.setMin,
                onMaxChanged: _controller.setMax,
              ),
              const SizedBox(height: RandomNumberConstants.spacing24),

              // Generate Button
              FilledButton.icon(
                onPressed: _handleGenerate,
                icon: const Icon(Icons.casino),
                label: Text(AppStrings.randomNumberGenerate),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: RandomNumberConstants.buttonPaddingHorizontal,
                    vertical: RandomNumberConstants.buttonPaddingVertical,
                  ),
                ),
              ),
              const SizedBox(height: RandomNumberConstants.bottomSpacing),
            ],
          );
        },
      ),
    );
  }
}
