// import 'package:device_id/device_id.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ygo_companion/widgets/app_banner_ad.dart';
import 'package:ygo_companion/widgets/calculator_type_list_tile.dart';
import 'package:ygo_companion/widgets/theme_switcher.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  BannerAd? _bannerAd;
  AdSize? _bannerAdSize;
  InterstitialAd? _interstitialAd;
  // String _deviceId;
  bool _canPop = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    // _interstitialAd is disposed in FullScreenContentCallback
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getBannerAdSize();
  }

  Future<void> init() async {
    _loadInterstitialAd();
  }

  _launchURL() async {
    final url = Uri.parse('https://www.facebook.com/ygoyutopia');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _getBannerAdSize() async {
    final adSize =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.sizeOf(context).width.truncate());

    if (adSize == null) {
      debugPrint("Cannot get banner ad size");
      return;
    }

    if (_bannerAdSize?.height != adSize.height ||
        _bannerAdSize?.width != adSize.width) {
      setState(() => _bannerAdSize = adSize);
    }
  }

  /// Loads interstitial ad
  void _loadInterstitialAd() {
    if (!Platform.isAndroid && !Platform.isIOS) {
      debugPrint("Not show Ad because platform is neither Android or iOS");
      return;
    }

    String adUnitId = kDebugMode
        ? Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/1033173712' // Test id on Android
            : 'ca-app-pub-3940256099942544/4411468910' // Test id on iOS
        : Platform.isAndroid
            // TODO replace with real unit ids
            ? 'ca-app-pub-3940256099942544/1033173712'
            : 'ca-app-pub-3940256099942544/4411468910';

    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {
                  setState(() => _canPop = true);
                },
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                  _interstitialAd = null;
                  Navigator.of(context).pop();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  _interstitialAd = null;
                  Navigator.of(context).pop();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  Widget _buildPartnershipAndAd() {
    return Column(
      children: <Widget>[
        const Text("Partnered with"),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10),
          ),
          onPressed: _launchURL,
          child: Image.asset(
            "assets/logo/yutopia_logo.png",
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.shortestSide * 0.5,
          ),
        ),
        if (_bannerAdSize != null) AppBannerAd(adSize: _bannerAdSize!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return PopScope(
      canPop: _canPop,
      onPopInvoked: (didPop) async {
        if (_interstitialAd != null) {
          await _interstitialAd?.show();
          return;
        }

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
                children: <Widget>[
                  if (kDebugMode) ...[
                    CalculatorTypeListTile(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Divider(thickness: 1),
                    ),
                  ],
                  SystemThemeSwitchListTile(),
                  ThemeSwitchListTile(),
                  if (orientation == Orientation.landscape)
                    _buildPartnershipAndAd(),
                ],
              ),
            ),
            if (orientation == Orientation.portrait) _buildPartnershipAndAd(),
          ],
        ),
      ),
    );
  }
}
