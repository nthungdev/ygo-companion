import 'package:flutter/material.dart';
import 'package:ygo_companion/utils/companion_theme.dart';

class CalculatorPad extends StatelessWidget {
  final double space;
  final double height;
  final Function(String key) onKeyPress;
  final Color color;

  const CalculatorPad({
    Key key,
    this.space = 5,
    this.height,
    this.color,
    this.onKeyPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyStyle = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w400,
    );
    const fontSizeScale = 0.4; // fontSize = 40% of the parent

    return SizedBox(
      height: height,
      child: Row(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 3 / 4,
            child: Container(
              color: Theme.of(context).backgroundColor.withAlpha(200),
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: "7,8,9,4,5,6,1,2,3,0,00,=".split(",").map((item) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return FlatButton(
                      textTheme: ButtonTextTheme.normal,
                      padding: EdgeInsets.all(0),
                      onPressed: () => this.onKeyPress != null ? this.onKeyPress(item) : null,
                      child: Text(
                        item.toString(),
                        style: keyStyle.copyWith(
                          fontSize: constraints.maxWidth * fontSizeScale,
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: this.space),
          AspectRatio(
            aspectRatio: 2 / 4,
            child: Container(
              color: Theme.of(context).backgroundColor.withAlpha(200),
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  FlatButton(
                    textTheme: ButtonTextTheme.normal,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => this.onKeyPress != null ? this.onKeyPress("x") : null,
                    child: Icon(Icons.backspace),
                  ),
                  ..."C,(,),+,x2,-,÷2".split(",").map((item) {
                    return LayoutBuilder(builder: (contex, constraints) {
                      return FlatButton(
                        textTheme: ButtonTextTheme.normal,
                        padding: const EdgeInsets.all(0),
                        onPressed: () => this.onKeyPress != null ? this.onKeyPress(item) : null,
                        child: Text(
                          item.toString(),
                          style: keyStyle.copyWith(
                            fontSize: constraints.maxWidth * fontSizeScale,
                            // color: Colors.black87,
                          ),
                        ),
                      );
                    });
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
