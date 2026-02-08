import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/dice_roller_constants.dart';
import '../../controllers/dice_roller_controller.dart';
import '../../widgets/animated_dice_widget.dart';
import '../../widgets/dice_results_card.dart';
import '../../widgets/dice_settings_card.dart';

class DiceRollerPage extends StatefulWidget {
  const DiceRollerPage({super.key});

  @override
  State<DiceRollerPage> createState() => _DiceRollerPageState();
}

class _DiceRollerPageState extends State<DiceRollerPage>
    with SingleTickerProviderStateMixin {
  late DiceRollerController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = DiceRollerController();
    _animationController = AnimationController(
      duration: const Duration(
        milliseconds: DiceRollerConstants.animationDurationMs,
      ),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleRollDice() {
    _controller.rollDice(() {
      _animationController.forward(from: 0).then((_) {
        _controller.completeRoll(() {
          _animationController.reverse();
        });
      });
    }, () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.diceRollerTitle)),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return ListView(
            padding: const EdgeInsets.all(DiceRollerConstants.paddingPage),
            children: [
              // Animation Section
              AnimatedDiceWidget(animation: _animation),
              const SizedBox(height: DiceRollerConstants.spacing16),

              // Results Section
              if (_controller.hasResults) ...[
                DiceResultsCard(
                  results: _controller.results,
                  total: _controller.total,
                  showTotal: _controller.shouldShowTotal,
                ),
                const SizedBox(height: DiceRollerConstants.spacing16),
              ],

              // Settings Section
              DiceSettingsCard(
                numberOfDice: _controller.numberOfDice,
                sides: _controller.sides,
                onNumberOfDiceChanged: _controller.setNumberOfDice,
                onSidesChanged: _controller.setSides,
              ),
              const SizedBox(height: DiceRollerConstants.spacing24),

              // Roll Button
              FilledButton.icon(
                onPressed: _controller.isRolling ? null : _handleRollDice,
                icon: const Icon(Icons.casino),
                label: Text(
                  _controller.isRolling
                      ? AppStrings.diceRollerRolling
                      : AppStrings.diceRollerRollButton,
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DiceRollerConstants.buttonPaddingHorizontal,
                    vertical: DiceRollerConstants.buttonPaddingVertical,
                  ),
                ),
              ),
              const SizedBox(height: DiceRollerConstants.bottomSpacing),
            ],
          );
        },
      ),
    );
  }
}
