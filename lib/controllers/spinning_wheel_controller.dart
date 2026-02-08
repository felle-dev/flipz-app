import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../config/spinning_wheel_constants.dart';

class SpinningWheelController extends ChangeNotifier {
  final List<String> _options = List.from(
    SpinningWheelConstants.defaultOptions,
  );
  final TextEditingController optionsController = TextEditingController();

  bool _isSpinning = false;
  String? _result;
  double _currentRotation = 0;
  bool _isEditing = false;

  // Getters
  List<String> get options => _options;
  bool get isSpinning => _isSpinning;
  String? get result => _result;
  double get currentRotation => _currentRotation;
  bool get isEditing => _isEditing;
  int get optionsCount => _options.length;

  SpinningWheelController() {
    optionsController.text = _options.join('\n');
  }

  void toggleEditing() {
    _isEditing = !_isEditing;
    if (!_isEditing) {
      optionsController.text = _options.join('\n');
    }
    notifyListeners();
  }

  UpdateOptionsResult updateOptions() {
    final newOptions = optionsController.text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (newOptions.length < SpinningWheelConstants.minOptions) {
      return UpdateOptionsResult(
        success: false,
        error: 'Need at least ${SpinningWheelConstants.minOptions} options',
      );
    }

    _options.clear();
    _options.addAll(newOptions);
    _isEditing = false;
    notifyListeners();

    return UpdateOptionsResult(success: true);
  }

  void removeOption(String optionName) {
    if (_options.length <= SpinningWheelConstants.minOptions) {
      return;
    }

    _options.remove(optionName);
    optionsController.text = _options.join('\n');
    notifyListeners();
  }

  bool canRemoveOption() {
    return _options.length > SpinningWheelConstants.minOptions;
  }

  SpinResult calculateSpin() {
    if (_isSpinning || _options.isEmpty) {
      return SpinResult(success: false);
    }

    _isSpinning = true;
    _result = null;
    notifyListeners();

    final random = Random();
    final spins =
        SpinningWheelConstants.minSpins +
        random.nextDouble() * SpinningWheelConstants.maxAdditionalSpins;
    final extraRotation = random.nextDouble() * 2 * pi;
    final endRotation = _currentRotation + (spins * 2 * pi) + extraRotation;

    return SpinResult(
      success: true,
      startRotation: _currentRotation,
      endRotation: endRotation,
    );
  }

  void completeSpin(double finalRotation) {
    final normalizedRotation = finalRotation % (2 * pi);
    final sectionAngle = (2 * pi) / _options.length;
    final selectedIndex =
        ((2 * pi - normalizedRotation) / sectionAngle).floor() %
        _options.length;

    _result = _options[selectedIndex];
    _currentRotation = finalRotation % (2 * pi);
    _isSpinning = false;
    notifyListeners();
  }

  List<Color> generateColors() {
    final colors = <Color>[];
    for (int i = 0; i < _options.length; i++) {
      final hue = (i * 360 / _options.length) % 360;
      colors.add(
        HSLColor.fromAHSL(
          1,
          hue,
          SpinningWheelConstants.colorHueSaturation,
          SpinningWheelConstants.colorHueLightness,
        ).toColor(),
      );
    }
    return colors;
  }

  @override
  void dispose() {
    optionsController.dispose();
    super.dispose();
  }
}

/// Result of a spin calculation
class SpinResult {
  final bool success;
  final double startRotation;
  final double endRotation;

  SpinResult({
    required this.success,
    this.startRotation = 0,
    this.endRotation = 0,
  });
}

/// Result of updating options
class UpdateOptionsResult {
  final bool success;
  final String? error;

  UpdateOptionsResult({required this.success, this.error});
}
