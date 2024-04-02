import 'package:flutter/material.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/utils/companion_theme.dart';

typedef void OnChangeCallback(bool isDark);

/// On: dark mode
///
/// Off: light mode
class ThemeSwitchListTile extends StatelessWidget {
  final OnChangeCallback? onChange;

  const ThemeSwitchListTile({
    super.key,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = ThemeState.of(context, listen: false);
    final brightness = Theme.of(context).brightness;

    return SwitchListTile.adaptive(
      activeColor: CompanionTheme.primaryColor,
      title: const Text("Dark Mode"),
      value: brightness == Brightness.light ? false : true,
      onChanged: themeState.mode == ThemeMode.system
          ? null
          : (isDark) {
              themeState.switchMode(isDark ? ThemeMode.dark : ThemeMode.light);
              onChange!(isDark);
            },
    );
  }
}

class SystemThemeSwitchListTile extends StatelessWidget {
  const SystemThemeSwitchListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = ThemeState.of(context, listen: false);
    final brightness = Theme.of(context).brightness;

    return SwitchListTile.adaptive(
      title: const Text("Auto Dark Mode"),
      subtitle: const Text("Follow OS setting"),
      value: themeState.mode == ThemeMode.system ? true : false,
      activeColor: CompanionTheme.primaryColor,
      onChanged: (usingSystem) {
        themeState.switchMode(
          usingSystem
              ? ThemeMode.system
              : brightness == Brightness.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
        );
      },
    );
  }
}
