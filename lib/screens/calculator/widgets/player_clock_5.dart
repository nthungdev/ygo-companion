import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ygo_companion/states/clock_state.dart';

class PlayerClock extends StatelessWidget {
  final double? width;
  final VoidCallback? onTap;
  final VoidCallback? onLongPressed;
  final String? label;
  final bool forPlayerA;

  const PlayerClock({
    super.key,
    this.width,
    this.label,
    this.onTap,
    this.onLongPressed,
    required this.forPlayerA,
  });

  String formattedMinutes(Duration? watch) {
    if (watch == null) {
      return "00";
    } else {
      return (watch.inSeconds ~/ 60).toString().padLeft(2, "0");
    }
  }

  String formattedSeconds(Duration? watch) {
    if (watch == null) {
      return "00";
    } else {
      return (watch.inSeconds % 60).toString().padLeft(2, "0");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPressed,
        child: LayoutBuilder(
          builder: (context, constraint) {
            final textStyle = TextStyle(fontSize: constraint.maxWidth * 0.3);

            return Container(
              width: width,
              color: Theme.of(context).colorScheme.background.withAlpha(200),
              child: Stack(
                children: <Widget>[
                  if (label != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          label!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withAlpha(125),
                          ),
                        ),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Selector<ClockState, Duration>(
                            selector: (_, state) => forPlayerA
                                ? state.currentDurationA
                                : state.currentDurationB,
                            builder: (_, watch, __) {
                              return Text(
                                formattedMinutes(watch),
                                style: textStyle,
                              );
                            },
                          ),
                        ),
                      ),
                      Text(":", style: textStyle),
                      Expanded(
                        flex: 1,
                        child: Selector<ClockState, Duration>(
                          selector: (_, state) => forPlayerA
                              ? state.currentDurationA
                              : state.currentDurationB,
                          builder: (_, watch, __) {
                            return Text(
                              formattedSeconds(watch),
                              style: textStyle,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
