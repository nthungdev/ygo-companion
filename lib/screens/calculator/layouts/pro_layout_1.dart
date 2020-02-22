import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProLayout1 extends StatefulWidget {
  @override
  _ProLayout1State createState() => _ProLayout1State();
}

class _ProLayout1State extends State<ProLayout1> {
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: <Widget>[
              lpColumn(),
              Expanded(child: centerColumn()),
              lpColumn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget newCalculatorPad() {
    List<String> allPads =
        "7,8,9,x,4,5,6,(,),1,2,3,+,x2,0,00,=,-,/2".split(",");
    List<String> numPads = "7,8,9,4,5,6,1,2,3,0,00,=".split(",");
    List<String> operPads = "x,(,),+,x2,-,/2".split(",");

    List<StaggeredTile> _staggeredTiles = List.generate(
      24,
      (index) => StaggeredTile.count(index == 3 ? 2 : 1, 1),
    );

    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
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
        VerticalDivider(color: Colors.black),
        Expanded(
          flex: 2,
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
        )
      ],
    );
  }

  Widget calculatorPad() {
    List<String> numPads =
        "7,8,9,x,C,4,5,6,(,),1,2,3,+,x2,0,00,=,-,/2".split(",");

    print(numPads);

    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: numPad(),
        ),
        Expanded(
          flex: 2,
          child: operatorPad(),
        ),
      ],
    );
  }

  Widget numPad() {
    List<String> numPads = "7,8,9,4,5,6,1,2,3,0,00,=".split(",");

    return GridView.count(
      primary: false,
      crossAxisCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: List.generate(
        numPads.length,
        (index) => FlatButton(
          onPressed: () => {},
          child: Text(numPads[index]),
        ),
      ),
    );
  }

  Widget operatorPad() {
    List<String> operatorPads = "(,),+,x2,-,/2".split(",");

    return Column(
      children: <Widget>[
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          onPressed: () => {},
          child: Text("c"),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: List.generate(
              operatorPads.length,
              (index) => FlatButton(
                onPressed: () => {},
                child: Text(operatorPads[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget toolBar() {
    return Row(
      children: <Widget>[
        Container(),
        Column(
          children: <Widget>[
            Container(),
            Row(
              children: <Widget>[
                Container(),
                Container(),
              ],
            )
          ],
        ),
        Container(),
      ],
    );
  }

  Widget centerColumn() {
    return Column(
      children: <Widget>[
        toolBar(),
        Expanded(
          child: newCalculatorPad(),
        ),
        // newCalculatorPad(),
      ],
    );
  }

  SizedBox lpColumn() {
    return SizedBox(
      width: 150,
      child: Container(
        color: Colors.green[200], // For dev
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                ),
              ),
              child: Text("8000"),
            ),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
