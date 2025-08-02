import 'package:flutter/material.dart';

import 'icons/custom_icons.dart';

class IconButtonsRow extends StatelessWidget {
  const IconButtonsRow({
    super.key,
    required this.height,
    required this.width,
    this.onCoin,
    this.onDice,
    this.onReset,
    this.onPlayPause,
    this.isPlaying = false,
  });

  final double height;
  final double width;
  final VoidCallback? onCoin;
  final VoidCallback? onDice;
  final VoidCallback? onReset;
  final VoidCallback? onPlayPause;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Theme.of(context).colorScheme.surface.withAlpha(200),
      child: Material(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: onReset,
              icon: const Icon(Icons.history),
              tooltip: "Reset clocks",
            ),
            IconButton(
              onPressed: onPlayPause,
              icon: isPlaying
                  ? const Icon(Icons.pause_circle_filled)
                  : const Icon(Icons.play_circle_filled),
              tooltip: isPlaying
                  ? "Pause last used clocks"
                  : "Start last used clocks",
            ),
            IconButton(
              onPressed: onCoin,
              icon: const Icon(CustomIcons.coin_circle),
              tooltip: "Toss a coin",
            ),
            IconButton(
              onPressed: onDice,
              icon: const Icon(CustomIcons.dice),
              tooltip: "Roll a dice",
            ),
          ],
        ),
      ),
    );
  }
}
