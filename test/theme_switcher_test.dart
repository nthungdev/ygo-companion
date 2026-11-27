import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/widgets/theme_switcher.dart';

Future<ThemeState> pumpSwitches(
  WidgetTester tester, {
  required Brightness systemBrightness,
  Map<String, Object> prefs = const {},
}) async {
  SharedPreferences.setMockInitialValues(prefs);
  final themeState = ThemeState(await SharedPreferences.getInstance());
  tester.platformDispatcher.platformBrightnessTestValue = systemBrightness;
  addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

  await tester.pumpWidget(
    ChangeNotifierProvider<ThemeState>.value(
      value: themeState,
      child: Consumer<ThemeState>(
        builder: (context, state, _) => MaterialApp(
          themeMode: state.mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const Scaffold(
            body: Column(children: [
              ThemeSectionHeader(),
              SystemThemeSwitchListTile(),
              ThemeSwitchListTile(),
            ]),
          ),
        ),
      ),
    ),
  );
  return themeState;
}

Finder tileFor(String title) => find.widgetWithText(SwitchListTile, title);

bool isOn(WidgetTester tester, String title) =>
    tester.widget<SwitchListTile>(tileFor(title)).value;

void main() {
  testWidgets('shows both switches under a Theme heading', (tester) async {
    await pumpSwitches(tester, systemBrightness: Brightness.light);
    expect(find.text('Theme'), findsOneWidget);
    expect(tileFor('Use system'), findsOneWidget);
    expect(tileFor('Dark mode'), findsOneWidget);
  });

  testWidgets('Dark mode is enabled while Use system is on', (tester) async {
    await pumpSwitches(tester, systemBrightness: Brightness.dark);
    expect(isOn(tester, 'Use system'), isTrue);
    expect(isOn(tester, 'Dark mode'), isTrue);
    expect(
      tester.widget<SwitchListTile>(tileFor('Dark mode')).onChanged,
      isNotNull,
    );
  });

  testWidgets('selecting Dark mode turns off Use system', (tester) async {
    final state =
        await pumpSwitches(tester, systemBrightness: Brightness.light);
    await tester.tap(tileFor('Dark mode'));
    await tester.pumpAndSettle();
    expect(state.mode, ThemeMode.dark);
    expect(isOn(tester, 'Use system'), isFalse);
    expect(isOn(tester, 'Dark mode'), isTrue);
  });

  testWidgets('turning Dark mode off while following a dark system gives light',
      (tester) async {
    final state = await pumpSwitches(tester, systemBrightness: Brightness.dark);
    await tester.tap(tileFor('Dark mode'));
    await tester.pumpAndSettle();
    expect(state.mode, ThemeMode.light);
    expect(isOn(tester, 'Use system'), isFalse);
    expect(isOn(tester, 'Dark mode'), isFalse);
  });

  testWidgets('selecting Use system sets Dark mode to the system theme',
      (tester) async {
    final state = await pumpSwitches(
      tester,
      systemBrightness: Brightness.dark,
      prefs: {'themeMode': 'light'},
    );
    expect(isOn(tester, 'Dark mode'), isFalse);
    await tester.tap(tileFor('Use system'));
    await tester.pumpAndSettle();
    expect(state.mode, ThemeMode.system);
    expect(isOn(tester, 'Dark mode'), isTrue);
  });

  test('theme mode persists, including system', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final state = ThemeState(prefs);
    await state.switchMode(ThemeMode.light);
    expect(ThemeState(prefs).mode, ThemeMode.light);
    await state.switchMode(ThemeMode.system);
    expect(ThemeState(prefs).mode, ThemeMode.system);
  });
}
