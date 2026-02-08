import 'dart:math';
import 'package:flutter/foundation.dart';
import '../../config/dice_roller_constants.dart';

class DiceRollerController extends ChangeNotifier {
  int _numberOfDice = DiceRollerConstants.defaultNumberOfDice;
  int _sides = DiceRollerConstants.defaultSides;
  List<int> _results = [];
  bool _isRolling = false;

  // Getters
  int get numberOfDice => _numberOfDice;
  int get sides => _sides;
  List<int> get results => _results;
  bool get isRolling => _isRolling;
  bool get hasResults => _results.isNotEmpty;

  int get total => _results.isEmpty ? 0 : _results.reduce((a, b) => a + b);
  bool get shouldShowTotal => _results.length > 1;

  void setNumberOfDice(int value) {
    _numberOfDice = value;
    notifyListeners();
  }

  void setSides(int value) {
    _sides = value;
    notifyListeners();
  }

  void rollDice(
    VoidCallback onAnimationStart,
    VoidCallback onAnimationComplete,
  ) {
    if (_isRolling) return;

    _isRolling = true;
    _results = [];
    notifyListeners();

    // Start animation
    onAnimationStart();
  }

  void completeRoll(VoidCallback onAnimationReverse) {
    final random = Random();
    _results = List.generate(
      _numberOfDice,
      (index) => random.nextInt(_sides) + 1,
    );
    _isRolling = false;
    notifyListeners();

    // Reverse animation
    onAnimationReverse();
  }

  void reset() {
    _results = [];
    _isRolling = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
