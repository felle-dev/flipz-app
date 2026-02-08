import 'package:flutter/foundation.dart';
import '../../config/coin_flip_constants.dart';

class CoinFlipController extends ChangeNotifier {
  String? _result;
  bool _isFlipping = false;

  // Getters
  String? get result => _result;
  bool get isFlipping => _isFlipping;
  bool get hasResult => _result != null;

  void flipCoin(
    VoidCallback onAnimationStart,
    VoidCallback onAnimationComplete,
  ) {
    if (_isFlipping) return;

    _isFlipping = true;
    _result = null;
    notifyListeners();

    // Start animation
    onAnimationStart();
  }

  void completeFlip(VoidCallback onAnimationReverse) {
    _result = CoinFlipConstants.getRandomResult();
    _isFlipping = false;
    notifyListeners();

    // Reverse animation
    onAnimationReverse();
  }

  void reset() {
    _result = null;
    _isFlipping = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
