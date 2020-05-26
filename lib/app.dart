import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ygo_companion/states/calculator_setting_state.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/states/watch_state.dart';
import 'package:ygo_companion/routes.dart';
import 'package:ygo_companion/utils/companion_theme.dart';

/// The root of YGO Companion app
class CompanionApp extends StatefulWidget {
  @override
  _CompanionAppState createState() => _CompanionAppState();
}

class _CompanionAppState extends State<CompanionApp> {
  /// Persist data loaded
  bool _initialized = false;
  ThemeState _themeState;
  CalculatorSettingState _calculatorSettingState;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (kDebugMode) {
      FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    } else {
      FirebaseAdMob.instance.initialize(appId: "ca-app-pub-5774186272498727~1646821376");
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    _themeState = ThemeState(prefs);
    _calculatorSettingState = CalculatorSettingState(prefs);

    await Future.wait([
      _themeState.init(),
      _calculatorSettingState.init(),
    ]);

    setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) return Container(color: Colors.white);

    return ChangeNotifierProvider<ThemeState>(
      create: (_) => _themeState,
      child: Consumer<ThemeState>(
        builder: (context, themeState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'YGO Companion',
            themeMode: themeState.mode,
            darkTheme: CompanionTheme.darkTheme,
            theme: CompanionTheme.lightTheme,
            initialRoute: "/home",
            routes: Routes.routes(context),
            builder: (__, widget) {
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (___) => WatchState()),
                  ChangeNotifierProvider(create: (___) => _calculatorSettingState),
                ],
                child: widget,
              );
            },
          );
        },
      ),
    );
  }
}
