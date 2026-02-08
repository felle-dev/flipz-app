import 'dart:math';
import 'package:flutter/material.dart';
import '../../config/coin_flip_constants.dart';

class AnimatedCoinWidget extends StatelessWidget {
  final Animation<double> animation;

  const AnimatedCoinWidget({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(
              CoinFlipConstants.perspectiveEntry,
              CoinFlipConstants.perspectiveRow,
              CoinFlipConstants.perspectiveValue,
            )
            ..rotateY(
              animation.value * pi * CoinFlipConstants.rotationMultiplier,
            ),
          child: Container(
            width: CoinFlipConstants.coinSize,
            height: CoinFlipConstants.coinSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.monetization_on,
                size: CoinFlipConstants.coinIconSize,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        );
      },
    );
  }
}
