import 'package:flutter/material.dart';

/// Model representing a Quick Settings Tile
class QuickTile {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const QuickTile({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickTile && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
