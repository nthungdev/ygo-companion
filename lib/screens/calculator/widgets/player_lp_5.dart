import 'package:flutter/material.dart';

class PlayerLP extends StatelessWidget {
  final int lp;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String? label;
  final bool selected;

  const PlayerLP({
    super.key,
    this.lp = 8000,
    this.label,
    this.onPressed,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    String lp = this.lp.toString();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        splashColor: Colors.white,
        child: Container(
          color: selected
              ? Theme.of(context).colorScheme.secondary.withAlpha(200)
              : Theme.of(context).colorScheme.surface.withAlpha(200),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Stack(
                children: <Widget>[
                  if (label != null)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          label!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color
                                ?.withAlpha(125),
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: Text(
                      lp,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: constraint.maxWidth * 0.3 - lp.length * 1.5,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
