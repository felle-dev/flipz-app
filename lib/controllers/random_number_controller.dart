import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../config/random_number_constants.dart';

class RandomNumberController extends ChangeNotifier {
  int _min = RandomNumberConstants.defaultMin;
  int _max = RandomNumberConstants.defaultMax;
  int? _result;

  final TextEditingController minController = TextEditingController(
    text: RandomNumberConstants.defaultMin.toString(),
  );
  final TextEditingController maxController = TextEditingController(
    text: RandomNumberConstants.defaultMax.toString(),
  );

  // Getters
  int get min => _min;
  int get max => _max;
  int? get result => _result;
  bool get hasResult => _result != null;

  void setMin(String value) {
    _min = int.tryParse(value) ?? RandomNumberConstants.defaultMin;
    notifyListeners();
  }

  void setMax(String value) {
    _max = int.tryParse(value) ?? RandomNumberConstants.defaultMax;
    notifyListeners();
  }

  GenerateResult generate() {
    if (_min >= _max) {
      return GenerateResult(
        success: false,
        error: 'Minimum must be less than maximum',
      );
    }

    final random = Random();
    _result = _min + random.nextInt(_max - _min + 1);
    notifyListeners();

    return GenerateResult(success: true, value: _result);
  }

  void reset() {
    _result = null;
    notifyListeners();
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }
}

/// Result of a number generation operation
class GenerateResult {
  final bool success;
  final int? value;
  final String? error;

  GenerateResult({required this.success, this.value, this.error});
}
