import 'package:flutter/material.dart';

class LpLogPL2 extends StatelessWidget {
  const LpLogPL2({
    Key key,
    @required this.boxColor,
    @required this.calculations,
  }) : super(key: key);

  final Color boxColor;
  final List calculations;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: boxColor,
      child: ListView.builder(
        itemCount: calculations.length,
        itemBuilder: (_, index) {
          return Container(
            child: Text(calculations[index]),
          );
        },
      ),
    );
  }
}
