import 'package:flutter/material.dart';
import 'package:ygo_companion/states/calculator_setting_state.dart';

class CalculatorTypeListTile extends StatefulWidget {
  const CalculatorTypeListTile({super.key});

  @override
  State<CalculatorTypeListTile> createState() => _CalculatorTypeListTileState();
}

class _CalculatorTypeListTileState extends State<CalculatorTypeListTile> {
  void _handleOptionSelected(CalculatorLayout layout) async {
    CalculatorSettingState state =
        CalculatorSettingState.of(context, listen: false);
    await state.changeLayout(layout);
  }

  void _showOptions() async {
    CalculatorSettingState state =
        CalculatorSettingState.of(context, listen: false);

    final result = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              ...CalculatorLayout.values.map((layout) {
                return RadioListTile(
                  value: layout,
                  groupValue: state.calculatorLayout,
                  onChanged: (value) async {
                    CalculatorSettingState state =
                        CalculatorSettingState.of(context, listen: false);

                    Navigator.pop(context);

                    await state.changeLayout(layout);
                  },
                  title: Text(state.getName(layout)),
                );

                // return SimpleDialogOption(
                //   onPressed: () {},
                //   child: Row(
                //     children: <Widget>[
                //       // Radio(),
                //       Text("Option ${layout.index}"),
                //     ],
                //   ),
                // );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 20),
                ],
              )
            ],
          );
        });

    print('result: $result');
  }

  @override
  Widget build(BuildContext context) {
    CalculatorSettingState state = CalculatorSettingState.of(context);

    return ListTile(
      onTap: _showOptions,
      title: const Text("Calculator Type"),
      subtitle: Text(state.getName(state.calculatorLayout)),
    );
  }
}
