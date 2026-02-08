import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/spinning_wheel_constants.dart';
import '../../controllers/spinning_wheel_controller.dart';
import '../../widgets/wheel_painters.dart';

class SpinningWheelPage extends StatefulWidget {
  const SpinningWheelPage({super.key});

  @override
  State<SpinningWheelPage> createState() => _SpinningWheelPageState();
}

class _SpinningWheelPageState extends State<SpinningWheelPage>
    with SingleTickerProviderStateMixin {
  late SpinningWheelController _controller;
  late AnimationController _animationController;
  Animation<double>? _animation; // Changed to nullable

  @override
  void initState() {
    super.initState();
    _controller = SpinningWheelController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: SpinningWheelConstants.animationDurationMs,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_animation != null) {
          _controller.completeSpin(_animation!.value);
        }
        if (mounted && _controller.result != null) {
          _showResultDialog(_controller.result!);
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleSpin() {
    final spinResult = _controller.calculateSpin();

    if (!spinResult.success) return;

    _animation =
        Tween<double>(
          begin: spinResult.startRotation,
          end: spinResult.endRotation,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutQuart,
          ),
        );

    _animationController.forward(from: 0);
  }

  void _handleUpdateOptions() {
    final result = _controller.updateOptions();

    if (!result.success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.error ?? '')));
    }
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => _WheelResultDialog(
        result: result,
        onSpinAgain: () {
          Navigator.of(context).pop();
          _handleSpin();
        },
        onRemove: () {
          Navigator.of(context).pop();
          _removeOption(result);
        },
        onDone: () => Navigator.of(context).pop(),
        canRemove: _controller.canRemoveOption(),
      ),
    );
  }

  void _removeOption(String optionName) {
    if (!_controller.canRemoveOption()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.spinningWheelNeedTwoOptions)),
      );
      return;
    }

    _controller.removeOption(optionName);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.spinningWheelRemoved(optionName))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.spinningWheelTitle)),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return ListView(
            padding: const EdgeInsets.all(SpinningWheelConstants.paddingPage),
            children: [
              // Wheel Display
              _WheelDisplayCard(
                animation: _animation,
                animationController: _animationController,
                isSpinning: _controller.isSpinning,
                currentRotation: _controller.currentRotation,
                options: _controller.options,
                colors: _controller.generateColors(),
              ),
              const SizedBox(height: SpinningWheelConstants.spacing24),

              // Spin Button
              FilledButton.icon(
                onPressed: _controller.isSpinning ? null : _handleSpin,
                icon: const Icon(Icons.refresh),
                label: Text(
                  _controller.isSpinning
                      ? AppStrings.spinningWheelSpinning
                      : AppStrings.spinningWheelSpin,
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpinningWheelConstants.buttonPaddingHorizontal,
                    vertical: SpinningWheelConstants.buttonPaddingVertical,
                  ),
                ),
              ),
              const SizedBox(height: SpinningWheelConstants.spacing16),

              // Options Card
              _WheelOptionsCard(
                isEditing: _controller.isEditing,
                optionsController: _controller.optionsController,
                options: _controller.options,
                colors: _controller.generateColors(),
                onToggleEdit: _controller.toggleEditing,
                onSave: _handleUpdateOptions,
              ),
              const SizedBox(height: SpinningWheelConstants.bottomSpacing),
            ],
          );
        },
      ),
    );
  }
}

// ==================== WHEEL DISPLAY WIDGET ====================

class _WheelDisplayCard extends StatelessWidget {
  final Animation<double>? animation; // Changed to nullable
  final AnimationController animationController;
  final bool isSpinning;
  final double currentRotation;
  final List<String> options;
  final List<Color> colors;

  const _WheelDisplayCard({
    required this.animation,
    required this.animationController,
    required this.isSpinning,
    required this.currentRotation,
    required this.options,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: SpinningWheelConstants.borderWidth,
        ),
        borderRadius: BorderRadius.circular(
          SpinningWheelConstants.borderRadius,
        ),
        color: theme.colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(SpinningWheelConstants.wheelPadding),
        child: Column(
          children: [
            // Arrow indicator
            CustomPaint(
              size: const Size(
                SpinningWheelConstants.arrowSize,
                SpinningWheelConstants.arrowSize,
              ),
              painter: ArrowPainter(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: SpinningWheelConstants.arrowSpacing),
            // Wheel
            SizedBox(
              width: SpinningWheelConstants.wheelSize,
              height: SpinningWheelConstants.wheelSize,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: isSpinning && animation != null
                        ? animation!.value
                        : currentRotation,
                    child: CustomPaint(
                      size: const Size(
                        SpinningWheelConstants.wheelSize,
                        SpinningWheelConstants.wheelSize,
                      ),
                      painter: WheelPainter(options: options, colors: colors),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== OPTIONS CARD WIDGET ====================

class _WheelOptionsCard extends StatelessWidget {
  final bool isEditing;
  final TextEditingController optionsController;
  final List<String> options;
  final List<Color> colors;
  final VoidCallback onToggleEdit;
  final VoidCallback onSave;

  const _WheelOptionsCard({
    required this.isEditing,
    required this.optionsController,
    required this.options,
    required this.colors,
    required this.onToggleEdit,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: SpinningWheelConstants.borderWidth,
        ),
        borderRadius: BorderRadius.circular(
          SpinningWheelConstants.borderRadius,
        ),
        color: theme.colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(SpinningWheelConstants.paddingCard),
            child: Row(
              children: [
                Icon(
                  Icons.list_alt_outlined,
                  color: theme.colorScheme.primary,
                  size: SpinningWheelConstants.iconSizeSmall,
                ),
                const SizedBox(width: SpinningWheelConstants.spacing8),
                Text(
                  AppStrings.spinningWheelOptions,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                FilledButton.tonalIcon(
                  onPressed: onToggleEdit,
                  icon: Icon(isEditing ? Icons.close : Icons.edit),
                  label: Text(
                    isEditing
                        ? AppStrings.spinningWheelCancel
                        : AppStrings.spinningWheelEdit,
                  ),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal:
                          SpinningWheelConstants.buttonPaddingSmallHorizontal,
                      vertical:
                          SpinningWheelConstants.buttonPaddingSmallVertical,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          Padding(
            padding: const EdgeInsets.all(
              SpinningWheelConstants.paddingCardContent,
            ),
            child: isEditing
                ? Column(
                    children: [
                      TextField(
                        controller: optionsController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: AppStrings.spinningWheelEnterOptions,
                          border: const OutlineInputBorder(),
                          helperText: AppStrings.spinningWheelHelperText,
                        ),
                      ),
                      const SizedBox(height: SpinningWheelConstants.spacing16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: onSave,
                          icon: const Icon(Icons.check),
                          label: Text(AppStrings.spinningWheelSaveOptions),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: SpinningWheelConstants
                                  .buttonPaddingDialogVertical,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppStrings.spinningWheelCurrentOptions} (${options.length}):',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: SpinningWheelConstants.spacing12),
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: SpinningWheelConstants.optionListMaxHeight,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: SpinningWheelConstants.spacing6,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: SpinningWheelConstants
                                        .colorIndicatorSize,
                                    height: SpinningWheelConstants
                                        .colorIndicatorSize,
                                    decoration: BoxDecoration(
                                      color: colors[index],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: SpinningWheelConstants
                                            .colorIndicatorBorder,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: SpinningWheelConstants.spacing12,
                                  ),
                                  Expanded(
                                    child: Text(
                                      options[index],
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ==================== RESULT DIALOG WIDGET ====================

class _WheelResultDialog extends StatelessWidget {
  final String result;
  final VoidCallback onSpinAgain;
  final VoidCallback onRemove;
  final VoidCallback onDone;
  final bool canRemove;

  const _WheelResultDialog({
    required this.result,
    required this.onSpinAgain,
    required this.onRemove,
    required this.onDone,
    required this.canRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          SpinningWheelConstants.borderRadiusDialog,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(SpinningWheelConstants.dialogPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: SpinningWheelConstants.dialogIconSize,
              height: SpinningWheelConstants.dialogIconSize,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.celebration,
                size: SpinningWheelConstants.iconSizeMedium,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: SpinningWheelConstants.spacing24),
            Text(
              AppStrings.spinningWheelWinner,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: SpinningWheelConstants.spacing16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SpinningWheelConstants.resultPaddingHorizontal,
                vertical: SpinningWheelConstants.resultPaddingVertical,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(
                  SpinningWheelConstants.borderRadiusResult,
                ),
              ),
              child: Text(
                result,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: SpinningWheelConstants.spacing24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: SpinningWheelConstants.spacing8,
              runSpacing: SpinningWheelConstants.spacing8,
              children: [
                FilledButton.icon(
                  onPressed: onSpinAgain,
                  icon: const Icon(Icons.refresh),
                  label: Text(AppStrings.spinningWheelSpinAgain),
                ),
                if (canRemove)
                  FilledButton.tonalIcon(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline),
                    label: Text(AppStrings.spinningWheelRemove),
                  ),
                OutlinedButton.icon(
                  onPressed: onDone,
                  icon: const Icon(Icons.check),
                  label: Text(AppStrings.spinningWheelDone),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
