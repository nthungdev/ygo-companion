import 'package:flutter/material.dart';

class MainClock extends StatelessWidget {
  final Duration clock;
  final Function onTap;
  final Color color;

  const MainClock({
    Key key,
    this.clock,
    this.onTap,
    this.color,
  })  : assert(clock != null),
        super(key: key);

  String get formattedMinutes {
    if (clock == null)
      return "00";
    else
      return (clock.inSeconds ~/ 60).toString().padLeft(2, "0");
  }

  String get formattedSeconds {
    if (clock == null)
      return "00";
    else
      return (clock.inSeconds % 60).toString().padLeft(2, "0");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final textStyle = TextStyle(fontSize: constraint.maxWidth * 0.3);

      return FlatButton(
        onPressed: onTap,
        textTheme: ButtonTextTheme.normal,
        padding: const EdgeInsets.only(),
        child: Container(
          color: Theme.of(context).backgroundColor.withAlpha(200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    formattedMinutes,
                    style: textStyle,
                  ),
                ),
              ),
              Text(":", style: textStyle),
              Expanded(
                flex: 1,
                child: Text(
                  formattedSeconds,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
