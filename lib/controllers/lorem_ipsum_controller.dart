import 'dart:math';
import 'package:random/config/lorem_constants.dart';

class LoremIpsumController {
  final Random _random = Random();

  String generateText({
    required String type,
    required int count,
    required bool startWithLorem,
  }) {
    switch (type) {
      case LoremConstants.typeWords:
        return _generateWords(count, startWithLorem);
      case LoremConstants.typeSentences:
        return _generateSentences(count, startWithLorem);
      case LoremConstants.typeParagraphs:
        return _generateParagraphs(count, startWithLorem);
      default:
        return '';
    }
  }

  String _generateWords(int count, bool startWithLorem) {
    final words = <String>[];

    if (startWithLorem) {
      words.addAll(LoremConstants.loremStart);
    }

    while (words.length < count) {
      words.add(
        LoremConstants.words[_random.nextInt(LoremConstants.words.length)],
      );
    }

    return words.take(count).join(' ');
  }

  String _generateSentences(int count, bool startWithLorem) {
    final sentences = <String>[];

    for (int i = 0; i < count; i++) {
      sentences.add(
        _generateSentence(startWithLorem: startWithLorem && i == 0),
      );
    }

    return sentences.join(' ');
  }

  String _generateParagraphs(int count, bool startWithLorem) {
    final paragraphs = <String>[];

    for (int i = 0; i < count; i++) {
      paragraphs.add(
        _generateParagraph(startWithLorem: startWithLorem && i == 0),
      );
    }

    return paragraphs.join('\n\n');
  }

  String _generateSentence({bool startWithLorem = false}) {
    final length =
        _random.nextInt(
          LoremConstants.maxWordsPerSentence -
              LoremConstants.minWordsPerSentence,
        ) +
        LoremConstants.minWordsPerSentence;

    final words = <String>[];

    if (startWithLorem) {
      words.addAll(LoremConstants.loremStart);
    }

    while (words.length < length) {
      words.add(
        LoremConstants.words[_random.nextInt(LoremConstants.words.length)],
      );
    }

    // Capitalize first letter
    words[0] = words[0][0].toUpperCase() + words[0].substring(1);

    return '${words.join(' ')}.';
  }

  String _generateParagraph({bool startWithLorem = false}) {
    final sentenceCount =
        _random.nextInt(
          LoremConstants.maxSentencesPerParagraph -
              LoremConstants.minSentencesPerParagraph,
        ) +
        LoremConstants.minSentencesPerParagraph;

    final sentences = <String>[];

    for (int i = 0; i < sentenceCount; i++) {
      sentences.add(
        _generateSentence(
          startWithLorem: startWithLorem && i == 0 && sentences.isEmpty,
        ),
      );
    }

    return sentences.join(' ');
  }

  int getMaxCount(String type) {
    switch (type) {
      case LoremConstants.typeWords:
        return LoremConstants.maxWords;
      case LoremConstants.typeSentences:
        return LoremConstants.maxSentences;
      case LoremConstants.typeParagraphs:
        return LoremConstants.maxParagraphs;
      default:
        return 10;
    }
  }

  int getDivisions(String type) {
    switch (type) {
      case LoremConstants.typeWords:
        return LoremConstants.maxWords - 1;
      case LoremConstants.typeSentences:
        return LoremConstants.maxSentences - 1;
      case LoremConstants.typeParagraphs:
        return LoremConstants.maxParagraphs - 1;
      default:
        return 9;
    }
  }
}
