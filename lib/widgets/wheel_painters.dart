import 'dart:math';
import 'package:flutter/material.dart';
import '../../../config/spinning_wheel_constants.dart';

/// Painter for the spinning wheel
class WheelPainter extends CustomPainter {
  final List<String> options;
  final List<Color> colors;

  WheelPainter({required this.options, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sectionAngle = (2 * pi) / options.length;

    for (int i = 0; i < options.length; i++) {
      // Draw section
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      final startAngle = i * sectionAngle - pi / 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngle,
        true,
        paint,
      );

      // Draw border
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = SpinningWheelConstants.sectionBorderWidth;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngle,
        true,
        borderPaint,
      );

      // Draw text
      final textAngle = startAngle + sectionAngle / 2;
      final (fontSize, textRadius) = _getTextSettings(options.length);

      final textX = center.dx + textRadius * radius * cos(textAngle);
      final textY = center.dy + textRadius * radius * sin(textAngle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: options[i],
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(textAngle);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }

    // Draw center circle
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      center,
      SpinningWheelConstants.centerCircleRadius,
      centerPaint,
    );
  }

  (double fontSize, double textRadius) _getTextSettings(int optionCount) {
    if (optionCount > 20) {
      return (
        SpinningWheelConstants.fontSizeSmall,
        SpinningWheelConstants.textRadiusSmall,
      );
    } else if (optionCount > 15) {
      return (
        SpinningWheelConstants.fontSizeMedium,
        SpinningWheelConstants.textRadiusMedium,
      );
    } else if (optionCount > 10) {
      return (
        SpinningWheelConstants.fontSizeNormal,
        SpinningWheelConstants.textRadiusNormal,
      );
    } else if (optionCount > 8) {
      return (
        SpinningWheelConstants.fontSizeLarge,
        SpinningWheelConstants.textRadiusLarge,
      );
    }
    return (
      SpinningWheelConstants.fontSizeDefault,
      SpinningWheelConstants.textRadiusDefault,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Painter for the arrow indicator
class ArrowPainter extends CustomPainter {
  final Color color;

  ArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
