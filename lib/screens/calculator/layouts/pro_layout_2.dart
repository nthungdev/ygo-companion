import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ygo_companion/screens/calculator/widgets/calculator_pad_pl2.dart';
import 'package:ygo_companion/screens/calculator/widgets/lp_log_pl2.dart';
import 'package:ygo_companion/screens/calculator/widgets/main_timer_pl2.dart';
import 'package:ygo_companion/screens/calculator/widgets/player_timer_pl2.dart';
import 'package:ygo_companion/size_config.dart';

class ProLayout2 extends StatefulWidget {
  @override
  _ProLayout2State createState() => _ProLayout2State();
}

class _ProLayout2State extends State<ProLayout2> {
  final _boxColor = Colors.white60;
  final _space = 5.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/calculator/background.png"),
          ),
        ),
        child: SafeArea(
          child: Container(
              padding: EdgeInsets.all(_space),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.blueAccent,
                      child: Text('1st layer'),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      // Expanded(
                      //   child: Container(),
                      // ),
                      Container(
                        width: 100,
                      ),
                      Text('hello'),
                      // CalculatorPadPL2(
                      //   boxColor: _boxColor,
                      //   space: _space,
                      // ),
                      // Expanded(
                      //   child: Container(),
                      // ),
                    ],
                  ),
                ],
              )

              // // Old layout Row First
              // child: Row(
              //   children: <Widget>[
              //     Expanded(
              //       flex: 1,
              //       child: _buildSideColumn(
              //         onResetTimer: () => {},
              //       ),
              //     ),
              //     SizedBox(width: _space), // Spacer
              //     Expanded(flex: 5, child: _buildCenterColumn()),
              //     SizedBox(width: _space), // Spacer
              //     Expanded(
              //       flex: 1,
              //       child: _buildSideColumn(
              //         isRight: true,
              //         onResetTimer: () => {},
              //       ),
              //     ),
              //   ],
              // ),
              ),
        ),
      ),
    );
  }

  Widget buildTile({Widget child}) {
    return Container(
      color: _boxColor,
      child: child,
    );
  }

  Widget buildLpBox([String lp = "8000"]) {
    return Container(
      color: _boxColor,
      child: Center(
        child: Text(
          lp,
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 3,
          ),
        ),
      ),
    );
  }

  Widget _buildLpTimerLp() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: buildLpBox(),
        ),
        SizedBox(width: _space), // Divider
        Expanded(
          flex: 5,
          child: buildMainTimer(),
        ),
        SizedBox(width: _space),
        Expanded(
          flex: 3,
          child: buildLpBox(),
        ),
      ],
    );
  }

  Widget buildMainTimer() {
    return MainTimerPL2(boxColor: _boxColor);
  }

  Widget _buildCenterColumn() {
    return Column(
      children: <Widget>[
        Expanded(flex: 1, child: _buildLpTimerLp()),
        SizedBox(height: _space),
        Expanded(
          flex: 4,
          child: CalculatorPadPL2(
            boxColor: _boxColor,
            space: _space,
          ),
        ),

        // CalculatorPadPL2(
        //   boxColor: _boxColor,
        //   space: _space,
        // ),
      ],
    );
  }

  /// Default to be left column
  Widget _buildSideColumn({
    bool isRight = false,
    Function onResetTimer,
  }) {
    final mockCalculations = [
      "8000",
      "-800",
      "7200",
      "-3000",
      "4200",
      "-500",
      "3700",
      "-1500",
      "2200",
      "-1200",
      "1000",
      "÷2",
      "500",
      "*2",
      "1000",
      "-100",
      "900",
      "-900",
      "0"
    ];

    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: PlayerTimerPL2(
            boxColor: _boxColor,
            onResetTimer: onResetTimer,
            time: Duration(seconds: 0),
            resetTimerPosition:
                isRight ? Alignment.topRight : Alignment.topLeft,
          ),
        ),
        SizedBox(height: _space),
        Expanded(
          flex: 4,
          child: LpLogPL2(boxColor: _boxColor, calculations: mockCalculations),
        ),
      ],
    );
  }
}
