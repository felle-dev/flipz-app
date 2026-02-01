import 'dart:math';
import 'package:flipz/config/username_constants.dart';

class UsernameGeneratorController {
  final Random _random = Random();

  String generateUsername({
    required bool includeAdjective,
    required bool includeNumbers,
    required bool capitalize,
    required String separator,
  }) {
    String username = '';

    if (includeAdjective) {
      String adjective = UsernameConstants
          .adjectives[_random.nextInt(UsernameConstants.adjectives.length)];
      if (!capitalize) adjective = adjective.toLowerCase();
      username += adjective;
    }

    if (includeAdjective && username.isNotEmpty) {
      username += separator;
    }

    String noun = UsernameConstants
        .nouns[_random.nextInt(UsernameConstants.nouns.length)];
    if (!capitalize) noun = noun.toLowerCase();
    username += noun;

    if (includeNumbers) {
      username += separator;
      username += (_random.nextInt(9000) + 1000).toString();
    }

    return username;
  }
}
