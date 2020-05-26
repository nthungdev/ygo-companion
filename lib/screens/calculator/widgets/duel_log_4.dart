import 'package:flutter/material.dart';

class DuelLog extends StatefulWidget {
  final bool show;
  final List<String> logs;
  final double width;
  final Color color;
  final String calculation;
  final bool selected;

  const DuelLog({
    Key key,
    this.width,
    this.show = false,
    this.logs = const [],
    this.calculation,
    this.selected = false,
    this.color,
  })  : assert(logs != null),
        super(key: key);

  @override
  _DuelLogState createState() => _DuelLogState();
}

class _DuelLogState extends State<DuelLog> {
  ScrollController _scrollController;
  double height;
  int logsSize;

  @override
  void initState() {
    super.initState();
    logsSize = widget.logs.length;

    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(DuelLog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (logsSize != widget.logs.length) {
      logsSize = widget.logs.length;

      Future.delayed(Duration.zero, () {
        if (_scrollController.position.maxScrollExtent != 0) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> logs = [...widget.logs, widget.calculation];
    logs = logs.expand((item) {
      if (logs.indexOf(item) % 2 == 1 && logs.indexOf(item) != logs.length - 1) {
        return [item, "divider"];
      } else
        return [item];
    }).toList();

    return Container(
      color: widget.selected
          ? Theme.of(context).accentColor.withAlpha(200)
          : Theme.of(context).backgroundColor.withAlpha(200),
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...List.generate(logs.length, (index) {
                  if (logs[index] == "divider")
                    return Divider(
                      color: Colors.black45,
                      height: 2,
                    );
                  else
                    return Text(
                      logs[index],
                      textAlign: TextAlign.right,
                      style:
                          index == logs.length - 2 ? TextStyle(fontWeight: FontWeight.bold) : null,
                    );
                }),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
