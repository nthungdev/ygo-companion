import 'package:flutter/material.dart';

class MainClock extends StatelessWidget {
  final Duration? clock;
  final void Function()? onTap;

  const MainClock({
    super.key,
    this.clock,
    this.onTap,
  }) : assert(clock != null);

  String get formattedMinutes {
    if (clock == null) {
      return "00";
    } else {
      return (clock!.inSeconds ~/ 60).toString().padLeft(2, "0");
    }
  }

  String get formattedSeconds {
    if (clock == null) {
      return "00";
    } else {
      return (clock!.inSeconds % 60).toString().padLeft(2, "0");
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final textStyle = TextStyle(fontSize: constraint.maxWidth * 0.25);

      return TextButton(
        onPressed: onTap,
        // TODO
        // textTheme: ButtonTextTheme.normal
        style: TextButton.styleFrom(
          textStyle: textStyle,
          padding: const EdgeInsets.only(),
        ),
        child: Container(
          color: Theme.of(context).colorScheme.surface.withAlpha(200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(formattedMinutes),
                ),
              ),
              Text(":"),
              Expanded(
                flex: 1,
                child: Text(formattedSeconds),
              ),
            ],
          ),
        ),
      );
    });
  }
}
