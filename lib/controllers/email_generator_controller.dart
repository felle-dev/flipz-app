import 'dart:math';
import 'package:flipz/config/email_constants.dart';

class EmailGeneratorController {
  final Random _random = Random();

  String generateEmail({
    required bool includeAdjective,
    required bool includeNumbers,
    required bool capitalize,
    required String separator,
    required String domain,
  }) {
    String localPart = '';

    if (includeAdjective) {
      String adjective = EmailConstants
          .adjectives[_random.nextInt(EmailConstants.adjectives.length)];
      if (capitalize) {
        adjective = adjective[0].toUpperCase() + adjective.substring(1);
      }
      localPart += adjective;
    }

    if (includeAdjective && localPart.isNotEmpty) {
      localPart += separator;
    }

    String noun =
        EmailConstants.nouns[_random.nextInt(EmailConstants.nouns.length)];
    if (capitalize) {
      noun = noun[0].toUpperCase() + noun.substring(1);
    }
    localPart += noun;

    if (includeNumbers) {
      localPart += separator;
      localPart += (_random.nextInt(9000) + 1000).toString();
    }

    return localPart + domain;
  }
}
