import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/dice_roller_constants.dart';

class AnimatedDiceWidget extends StatelessWidget {
  final Animation<double> animation;

  const AnimatedDiceWidget({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: DiceRollerConstants.borderWidth,
        ),
        borderRadius: BorderRadius.circular(DiceRollerConstants.borderRadius),
        color: theme.colorScheme.surface,
      ),
      child: Padding(
        padding: const EdgeInsets.all(DiceRollerConstants.paddingCard),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: animation.value * pi * 2,
              child: Icon(
                Icons.casino,
                size: DiceRollerConstants.iconSizeLarge,
                color: theme.colorScheme.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
