// import 'package:device_id/device_id.dart';
// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ygo_companion/widgets/calculator_type_list_tile.dart';
import 'package:ygo_companion/widgets/theme_switcher.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // BannerAd _bannerAd;
  // InterstitialAd _interstitialAd;
  // String _deviceId;
  // final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   childDirected: false,
  //   nonPersonalizedAds: true,
  // );
  bool _canPop = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    // _interstitialAd?.dispose();
    super.dispose();
  }

  Future<void> init() async {
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();

    // _interstitialAd = createInterstitialAd()..load();
    // _deviceId = await DeviceId.getID;
    // print('device id $_deviceId');
  }

  _launchURL() async {
    final url = Uri.https('https://www.facebook.com/ygoyutopia');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
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

  // BannerAd createBannerAd() {
  //   return BannerAd(
  //     adUnitId: kDebugMode
  //         ? BannerAd.testAdUnitId
  //         : 'ca-app-pub-2953470737526040/3191146376',
  //     size: AdSize.smartBanner,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event $event");
  //     },
  //   );
  // }

  // InterstitialAd createInterstitialAd() {
  //   return InterstitialAd(
  //     adUnitId: kDebugMode
  //         ? InterstitialAd.testAdUnitId
  //         : "ca-app-pub-2953470737526040/7597295246",
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("InterstitialAd event $event");
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // print("Setting Screen build... ${AdSize.largeBanner}");

    return PopScope(
      canPop: _canPop,
      onPopInvoked: (didPop) async {
        print("didPop $didPop");
        print("_canPop $_canPop");
        // final result = await _interstitialAd?.show();
        // print('_interstitialAd result $result');
        _canPop = true;
        if (!didPop) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Setting")),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(5),
                children: const <Widget>[
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
                const Text("Partner with"),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                  ),
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
