import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/utils/companion_theme.dart';

typedef void OnChangeCallback(bool isDark);

/// On: dark mode
///
/// Off: light mode
class ThemeSwitchListTile extends StatelessWidget {
  const ThemeSwitchListTile({
    Key key,
    this.onChange,
  }) : super(key: key);

  final OnChangeCallback onChange;

  @override
  Widget build(BuildContext context) {
    final themeState = ThemeState.of(context, listen: false);
    final brightness = Theme.of(context).brightness;

    return SwitchListTile.adaptive(
      activeColor: CompanionTheme.primaryColor,
      title: Text("Dark Mode"),
      value: brightness == Brightness.light ? false : true,
      onChanged: themeState.mode == ThemeMode.system
          ? null
          : (dark) {
              if (dark) {
                themeState.switchMode(ThemeMode.dark);
              } else
                themeState.switchMode(ThemeMode.light);

              if (onChange != null) onChange(dark);
            },
    );
  }
}

class SystemThemeCheckboxListTile extends StatelessWidget {
  const SystemThemeCheckboxListTile({
    Key key,
    this.onChange,
  }) : super(key: key);

  final OnChangeCallback onChange;

  @override
  Widget build(BuildContext context) {
    final themeState = ThemeState.of(context, listen: false);

    return CheckboxListTile(
      title: Text("Use System Theme"),
      value: themeState.mode == ThemeMode.system ? true : false,
      activeColor: CompanionTheme.primaryColor,
      onChanged: (usingSystem) {
        themeState.switchMode(usingSystem ? ThemeMode.system : ThemeMode.light);
      },
    );
  }
}
