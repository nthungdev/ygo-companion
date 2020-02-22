import 'package:flutter/material.dart';
import 'package:ygo_companion/size_config.dart';
import "package:ygo_companion/util/formatter.dart" as Formatter;

class PlayerTimerPL2 extends StatelessWidget {
  final Color boxColor;
  final Function onResetTimer;
  final AlignmentGeometry resetTimerPosition;
  final Duration time;

  const PlayerTimerPL2(
      {Key key,
      this.time,
      @required this.boxColor,
      this.onResetTimer,
      this.resetTimerPosition})
      : assert(time != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.boxColor,
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              Formatter.durationToDigital(this.time),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 3,
              ),
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(1),
            color: Colors.transparent,
            child: Align(
              alignment: this.resetTimerPosition,
              child: IconButton(
                onPressed: this.onResetTimer,
                color: Colors.black,
                alignment: this.resetTimerPosition,
                padding: EdgeInsets.all(0),
                splashColor: Colors.yellow,
                visualDensity: VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                icon: Icon(
                  Icons.history,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
