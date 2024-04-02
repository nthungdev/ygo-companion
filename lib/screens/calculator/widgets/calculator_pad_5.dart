import 'package:flutter/material.dart';

class CalculatorPad extends StatelessWidget {
  final double space;
  final double? height;
  final Function(String key)? onKeyPress;

  const CalculatorPad({
    super.key,
    this.space = 5,
    this.height,
    this.onKeyPress,
  });

  @override
  Widget build(BuildContext context) {
    const keyStyle = TextStyle(
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
              color: Theme.of(context).colorScheme.background.withAlpha(200),
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: "7,8,9,4,5,6,1,2,3,0,00,=".split(",").map((item) {
                  return LayoutBuilder(builder: (context, constraints) {
                    return TextButton(
                      // TODO ButtonTextTheme.normal?
                      // style: ButtonStyle(
                      //   // textTheme: ButtonTextTheme.normal,
                      // ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () => onKeyPress!(item),
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
          SizedBox(width: space),
          AspectRatio(
            aspectRatio: 2 / 4,
            child: Container(
              color: Theme.of(context).colorScheme.background.withAlpha(200),
              child: GridView.count(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  TextButton(
                    // TODO
                    // textTheme: ButtonTextTheme.normal,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    onPressed: () => onKeyPress!("x"),
                    child: const Icon(Icons.backspace),
                  ),
                  ..."C,(,),+,x2,-,÷2".split(",").map((item) {
                    return LayoutBuilder(builder: (contex, constraints) {
                      return TextButton(
                        // TODO
                        // textTheme: ButtonTextTheme.normal,
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                        ),
                        onPressed: () => onKeyPress!(item),
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
