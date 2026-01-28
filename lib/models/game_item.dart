import 'package:flutter/material.dart';

class GameItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color containerColor;
  final Widget Function() pageBuilder;
  bool isPinned;

  GameItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.containerColor,
    required this.pageBuilder,
    this.isPinned = false,
  });
}
