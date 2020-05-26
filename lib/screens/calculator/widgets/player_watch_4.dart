import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ygo_companion/states/watch_state.dart';

class PlayerWatch extends StatelessWidget {
  final double width;
  final Duration watch;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onLongPressed;
  final String label;
  final bool forPlayerA;

  const PlayerWatch({
    Key key,
    this.width,
    this.label,
    this.watch,
    this.color,
    this.onTap,
    @required this.forPlayerA,
    this.onLongPressed,
  }) : super(key: key);

  String formattedMinutes(Duration watch) {
    if (watch == null)
      return "00";
    else
      return (watch.inSeconds ~/ 60).toString().padLeft(2, "0");
  }

  String formattedSeconds(Duration watch) {
    if (watch == null)
      return "00";
    else
      return (watch.inSeconds % 60).toString().padLeft(2, "0");
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
              color: Theme.of(context).backgroundColor.withAlpha(200),
              child: Stack(
                children: <Widget>[
                  if (label != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.body1.color.withAlpha(125),
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
                          child: Selector<WatchState, Duration>(
                            selector: (_, state) =>
                                forPlayerA ? state.currentDurationA : state.currentDurationB,
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
                        child: Selector<WatchState, Duration>(
                          selector: (_, state) =>
                              forPlayerA ? state.currentDurationA : state.currentDurationB,
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
