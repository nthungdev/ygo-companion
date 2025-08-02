import 'package:flutter/material.dart';

class DuelLog extends StatefulWidget {
  final bool show;
  final List<String> logs;
  final String calculation;
  final bool selected;

  const DuelLog({
    super.key,
    this.show = false,
    this.logs = const [],
    this.selected = false,
    required this.calculation,
  });

  @override
  State<DuelLog> createState() => _DuelLogState();
}

class _DuelLogState extends State<DuelLog> {
  final ScrollController _scrollController = ScrollController();
  late int logsSize;

  @override
  void initState() {
    super.initState();
    logsSize = widget.logs.length;
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
      if (logs.indexOf(item) % 2 == 1 &&
          logs.indexOf(item) != logs.length - 1) {
        return [item, "divider"];
      } else {
        return [item];
      }
    }).toList();

    return Container(
      color: widget.selected
          ? Theme.of(context).colorScheme.secondary.withAlpha(200)
          : Theme.of(context).colorScheme.surface.withAlpha(200),
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...List.generate(logs.length, (index) {
                  if (logs[index] == "divider") {
                    return const Divider(
                      color: Colors.black45,
                      height: 2,
                    );
                  } else {
                    return Text(
                      logs[index],
                      textAlign: TextAlign.right,
                      style: index == logs.length - 2
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : null,
                    );
                  }
                }),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
