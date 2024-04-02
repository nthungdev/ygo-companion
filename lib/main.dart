import 'package:flutter/material.dart';
import 'package:ygo_companion/routes.dart';
import 'package:ygo_companion/states/calculator_setting_state.dart';
import 'package:ygo_companion/states/clock_state.dart';
import 'package:ygo_companion/states/theme_state.dart';
import 'package:ygo_companion/utils/companion_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const CompanionApp());
}

class CompanionApp extends StatefulWidget {
  const CompanionApp({super.key});

  @override
  State<CompanionApp> createState() => _CompanionAppState();
}

class _CompanionAppState extends State<CompanionApp> {
  bool _initialized = false;
  late ThemeState _themeState;
  late CalculatorSettingState _calculatorSettingState;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // TODO init AdMob
    // if (kDebugMode) {
    //   FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    // } else {
    //   FirebaseAdMob.instance
    //       .initialize(appId: "ca-app-pub-5774186272498727~1646821376");
    // }

    // init SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // init theme state
    _themeState = ThemeState(prefs);

    // init calculator state
    _calculatorSettingState = CalculatorSettingState(prefs);
    _calculatorSettingState.init();

    setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    // TODO maybe not the cleaniness placeholder
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
                  ChangeNotifierProvider(create: (___) => ClockState()),
                  ChangeNotifierProvider(
                      create: (___) => _calculatorSettingState),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
