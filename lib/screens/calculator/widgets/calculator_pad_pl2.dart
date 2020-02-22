import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalculatorPadPL2 extends StatelessWidget {
  const CalculatorPadPL2({
    Key key,
    @required this.boxColor,
    @required this.space,
  }) : super(key: key);

  final Color boxColor;
  final double space;

  @override
  Widget build(BuildContext context) {
    List<String> numPads = "7,8,9,4,5,6,1,2,3,0,00,=".split(",");
    List<String> operPads = ",C,(,),+,-,x2,÷2".split(",");

    List<StaggeredTile> _staggeredTiles = List.generate(
      24,
      (index) => StaggeredTile.count(1, 1),
    );

    return Container(
      child: Row(
        children: <Widget>[
          Container(
            color: this.boxColor,
            child: AspectRatio(
              aspectRatio: 3 / 4,
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

            // child: Column(
            //   children: <Widget>[
            //     Expanded(
            //       child: AspectRatio(
            //         aspectRatio: 3 / 4,
            //         child: StaggeredGridView.count(
            //           physics: NeverScrollableScrollPhysics(),
            //           crossAxisCount: 3,
            //           staggeredTiles: _staggeredTiles.getRange(4, 21).toList(),
            //           children: List.generate(
            //             numPads.length,
            //             (index) => FlatButton(
            //               child: Text(numPads[index]),
            //               onPressed: () => {},
            //             ),
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ),
          SizedBox(width: space), // Divider
          // Column(
          //   children: <Widget>[
          //     Expanded(
          //       child: AspectRatio(
          //         aspectRatio: 2 / 4,
          //         child: Container(
          //           color: boxColor,
          //           child: StaggeredGridView.count(
          //             physics: NeverScrollableScrollPhysics(),
          //             crossAxisCount: 2,
          //             staggeredTiles: _staggeredTiles.getRange(3, 12).toList(),
          //             children: List.generate(
          //               operPads.length,
          //               (index) => FlatButton(
          //                 child: operPads[index] == ""
          //                     ? Icon(Icons.backspace)
          //                     : Text(operPads[index]),
          //                 onPressed: () => {},
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );

    // // Old layout
    // return Row(
    //   children: <Widget>[
    //     Expanded(
    //       flex: 3,
    //       child: Container(
    //         color: this.boxColor,
    //         child: Column(
    //           children: <Widget>[
    //             Expanded(
    //               child: AspectRatio(
    //                 aspectRatio: 3 / 4,
    //                 child: Container(
    //                   // color: Colors.blue,
    //                   child: StaggeredGridView.count(
    //                     // physics: NeverScrollableScrollPhysics(),
    //                     crossAxisCount: 3,
    //                     staggeredTiles:
    //                         _staggeredTiles.getRange(4, 21).toList(),
    //                     children: List.generate(
    //                       numPads.length,
    //                       (index) => FlatButton(
    //                         child: Text(numPads[index]),
    //                         onPressed: () => {},
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     SizedBox(width: space), // Divider

    //     Expanded(
    //       flex: 2,
    //       child: Container(
    //         color: boxColor,
    //         child: StaggeredGridView.count(
    //           physics: NeverScrollableScrollPhysics(),
    //           crossAxisCount: 2,
    //           staggeredTiles: _staggeredTiles.getRange(3, 12).toList(),
    //           children: List.generate(
    //             operPads.length,
    //             (index) => FlatButton(
    //               child: operPads[index] == ""
    //                   ? Icon(Icons.backspace)
    //                   : Text(operPads[index]),
    //               onPressed: () => {},
    //             ),
    //           ),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}
