import 'package:device_id/device_id.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ygo_companion/widgets/calculator_type_list_tile.dart';
import 'package:ygo_companion/widgets/theme_switcher.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  String _deviceId;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    childDirected: false,
    nonPersonalizedAds: true,
  );

  Future<void> init() async {
    _bannerAd = createBannerAd()
      ..load()
      ..show();

    _interstitialAd = createInterstitialAd()..load();
    _deviceId = await DeviceId.getID;
    print('device id $_deviceId');
  }

  _launchURL() async {
    const url = 'https://www.facebook.com/ygoyutopia';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  double _getSmartBannerHeight() {
    final deviceHeight = MediaQuery.of(context).size.height;

    if (deviceHeight <= 400) {
      return 32;
    } else if (deviceHeight > 400 && deviceHeight <= 720) {
      return 55;
    } else
      return 90;
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: kDebugMode ? BannerAd.testAdUnitId : 'ca-app-pub-2953470737526040/3191146376',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: kDebugMode ? InterstitialAd.testAdUnitId : "ca-app-pub-2953470737526040/7597295246",
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Setting Screen build... ${AdSize.largeBanner}");

    return WillPopScope(
      onWillPop: () async {
        final result = await _interstitialAd?.show();
        print('_interstitialAd result $result');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Setting")),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(5),
                children: <Widget>[
                  if (kDebugMode) ...[
                    CalculatorTypeListTile(),
                    Divider(thickness: 1),
                  ],
                  SystemThemeSwitchListTile(),
                  ThemeSwitchListTile(),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text("Partner with"),
                FlatButton(
                  padding: EdgeInsets.all(5),
                  onPressed: _launchURL,
                  child: Image.asset(
                    "assets/logo/yutopia_logo.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.shortestSide * 0.5,
                  ),
                ),
                SizedBox(height: _getSmartBannerHeight()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
