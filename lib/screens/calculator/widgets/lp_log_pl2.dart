import 'package:flutter/material.dart';

class LpLogPL2 extends StatelessWidget {
  const LpLogPL2({
    super.key,
    required this.boxColor,
    required this.calculations,
  });

  final Color boxColor;
  final List calculations;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: boxColor,
      child: ListView.builder(
        itemCount: calculations.length,
        itemBuilder: (_, index) {
          return Text(calculations[index]);
        },
      ),
    );
  }
}
