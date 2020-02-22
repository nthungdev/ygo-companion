import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ygo_companion/size_config.dart';

class ProLayout3 extends StatefulWidget {
  @override
  _ProLayout3State createState() => _ProLayout3State();
}

class _ProLayout3State extends State<ProLayout3> {
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

    List<String> numPads = "7,8,9,4,5,6,1,2,3,0,00,=".split(",");
    List<String> operPads = ",x,(,),+,x2,-,/2".split(",");

    List<StaggeredTile> _staggeredTiles = List.generate(
      24,
      (index) => StaggeredTile.count(1, 1),
    );

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
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.safeBlockVertical,
              horizontal: SizeConfig.safeBlockHorizontal,
            ),

            child: Column(
              children: <Widget>[
                Container(),
                // buildRow2(),
                Container(
                  child: StaggeredGridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    staggeredTiles: _staggeredTiles.getRange(0, 3).toList(),
                    children: List.generate(
                      numPads.length,
                      (index) => FlatButton(
                        child: Text(numPads[index]),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // child: Row(
            //   children: <Widget>[
            //     Expanded(flex: 1, child: sideColumn()),
            //     SizedBox(width: 5), // Spacer
            //     Expanded(flex: 3, child: centerColumn()),
            //     SizedBox(width: 5), // Spacer
            //     Expanded(flex: 1, child: sideColumn()),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  Widget buildRow2() {
    List<String> numPads = "7,8,9,4,5,6,1,2,3,0,00,=".split(",");
    List<String> operPads = ",x,(,),+,x2,-,/2".split(",");

    List<StaggeredTile> _staggeredTiles = List.generate(
      24,
      (index) => StaggeredTile.count(1, 1),
    );

    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white60,
            child: StaggeredGridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              staggeredTiles: _staggeredTiles.getRange(4, 21).toList(),
              children: List.generate(
                numPads.length,
                (index) => FlatButton(
                  child: Text(numPads[index]),
                  onPressed: () => {},
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white60,
            child: StaggeredGridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              staggeredTiles: _staggeredTiles.getRange(3, 12).toList(),
              children: List.generate(
                operPads.length,
                (index) => FlatButton(
                  child: Text(operPads[index]),
                  onPressed: () => {},
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }

  Widget newCalculatorPad() {
    List<String> numPads = "7,8,9,4,5,6,1,2,3,0,00,=".split(",");
    List<String> operPads = ",x,(,),+,x2,-,/2".split(",");

    List<StaggeredTile> _staggeredTiles = List.generate(
      24,
      (index) => StaggeredTile.count(1, 1),
    );

    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white60,
            child: StaggeredGridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              staggeredTiles: _staggeredTiles.getRange(4, 21).toList(),
              children: List.generate(
                numPads.length,
                (index) => FlatButton(
                  child: Text(numPads[index]),
                  onPressed: () => {},
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.white60,
            child: StaggeredGridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              staggeredTiles: _staggeredTiles.getRange(3, 12).toList(),
              children: List.generate(
                operPads.length,
                (index) => FlatButton(
                  child: Text(operPads[index]),
                  onPressed: () => {},
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget toolBar() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            // height: (SizeConfig.safeBlockVertical * 20),
            color: Colors.white60,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    "8000",
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 5,
          child: Container(
            // height: (SizeConfig.safeBlockVertical * 20),
            color: Colors.white60,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: Container(
            // height: (SizeConfig.safeBlockVertical * 20),
            color: Colors.white60,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }

  Widget centerColumn() {
    return Column(
      children: <Widget>[
        Expanded(flex: 1, child: toolBar()),
        SizedBox(height: 5),
        Expanded(flex: 4, child: newCalculatorPad()),
        // newCalculatorPad(),
      ],
    );
  }

  Widget sideColumn() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            // width: double.maxFinite,
            // height: (SizeConfig.safeBlockVertical * 20),
            color: Colors.white60,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    "00:00",
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Expanded(
          flex: 4,
          child: Container(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }
}
