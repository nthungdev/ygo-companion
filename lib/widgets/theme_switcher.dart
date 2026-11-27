import 'package:flutter/material.dart';

import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/utils/companion_theme.dart';

typedef OnChangeCallback = void Function(bool isDark);

/// On: dark mode
///
/// Off: light mode
///
/// Always available. Changing it turns off "Use system".
class ThemeSwitchListTile extends StatelessWidget {
  final OnChangeCallback? onChange;

  const ThemeSwitchListTile({
    super.key,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = ThemeState.of(context);
    final brightness = Theme.of(context).brightness;

    return SwitchListTile.adaptive(
      activeColor: CompanionTheme.primaryColor,
      title: const Text("Dark mode"),
      // Follows the system theme while "Use system" is on.
      value: brightness == Brightness.dark,
      onChanged: (isDark) {
        themeState.switchMode(isDark ? ThemeMode.dark : ThemeMode.light);
        onChange?.call(isDark);
      },
    );
  }
}

/// On: follow the system theme, and "Dark mode" shows the system theme.
///
/// Off: keep the current theme as a manual choice.
class SystemThemeSwitchListTile extends StatelessWidget {
  const SystemThemeSwitchListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = ThemeState.of(context);
    final brightness = Theme.of(context).brightness;

    return SwitchListTile.adaptive(
      title: const Text("Use system"),
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

/// Section heading for the theme switches.
class ThemeSectionHeader extends StatelessWidget {
  const ThemeSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      header: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(
          "Theme",
          style: textTheme.titleSmall?.copyWith(
            color: CompanionTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
