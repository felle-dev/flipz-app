import 'package:flutter/material.dart';
import '../../config/app_strings.dart';
import '../../config/coin_flip_constants.dart';
import '../../controllers/coin_flip_controller.dart';
import '../../widgets/animated_coin_widget.dart';

class CoinFlipPage extends StatefulWidget {
  const CoinFlipPage({super.key});

  @override
  State<CoinFlipPage> createState() => _CoinFlipPageState();
}

class _CoinFlipPageState extends State<CoinFlipPage>
    with SingleTickerProviderStateMixin {
  late CoinFlipController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = CoinFlipController();
    _animationController = AnimationController(
      duration: const Duration(
        milliseconds: CoinFlipConstants.animationDurationMs,
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

  void _handleFlipCoin() {
    _controller.flipCoin(() {
      _animationController.forward(from: 0).then((_) {
        _controller.completeFlip(() {
          _animationController.reverse();
        });
      });
    }, () {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.coinFlipTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(CoinFlipConstants.paddingPage),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(CoinFlipConstants.paddingCard),
              child: ListenableBuilder(
                listenable: _controller,
                builder: (context, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedCoinWidget(animation: _animation),
                      const SizedBox(height: CoinFlipConstants.spacingMedium),
                      if (_controller.hasResult) ...[
                        Text(
                          _controller.result == CoinFlipConstants.resultHeads
                              ? AppStrings.coinFlipHeads
                              : AppStrings.coinFlipTails,
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: CoinFlipConstants.spacingSmall),
                      ],
                      FilledButton.icon(
                        onPressed: _controller.isFlipping
                            ? null
                            : _handleFlipCoin,
                        icon: const Icon(Icons.sync),
                        label: Text(
                          _controller.isFlipping
                              ? AppStrings.coinFlipFlipping
                              : AppStrings.coinFlipButton,
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal:
                                CoinFlipConstants.buttonPaddingHorizontal,
                            vertical: CoinFlipConstants.buttonPaddingVertical,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
