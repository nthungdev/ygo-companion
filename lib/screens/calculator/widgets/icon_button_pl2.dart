import 'package:flutter/material.dart';

/// [IconButton] wrapper for Pro Layout 2
class IconButtonPL2 extends StatelessWidget {
  final Widget icon;
  final Function onPressed;

  const IconButtonPL2({
    Key key,
    this.icon,
    this.onPressed,
  })  : assert(icon != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(0),
      splashColor: Colors.yellow,
      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      icon: this.icon,
      onPressed: this.onPressed,
    );
  }
}
