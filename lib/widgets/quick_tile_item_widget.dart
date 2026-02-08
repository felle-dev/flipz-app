import 'package:flutter/material.dart';
import '../../config/quick_tiles_constants.dart';
import '../../models/quick_tile.dart';

class QuickTileItemWidget extends StatelessWidget {
  final QuickTile tile;
  final bool isActive;
  final Function(bool) onToggle;

  const QuickTileItemWidget({
    super.key,
    required this.tile,
    required this.isActive,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(QuickTilesConstants.tileIconPadding),
        decoration: BoxDecoration(
          color: tile.color.withOpacity(QuickTilesConstants.tileColorOpacity),
          borderRadius: BorderRadius.circular(
            QuickTilesConstants.tileIconBorderRadius,
          ),
        ),
        child: Icon(tile.icon, color: tile.color),
      ),
      title: Text(tile.title),
      subtitle: Text(tile.subtitle),
      trailing: Switch(value: isActive, onChanged: onToggle),
    );
  }
}
