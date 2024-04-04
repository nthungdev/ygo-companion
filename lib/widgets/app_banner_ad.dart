import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppBannerAd extends StatefulWidget {
  /// The requested size of the banner. Defaults to [AdSize.banner].
  final AdSize adSize;

  const AppBannerAd({
    super.key,
    this.adSize = AdSize.banner,
  });

  @override
  State<AppBannerAd> createState() => _AppBannerAdState();
}

class _AppBannerAdState extends State<AppBannerAd> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppBannerAd oldWidget) {
    super.didUpdateWidget(oldWidget);

    // make sure the ad size is different before loading the ad
    if (widget.adSize.height != oldWidget.adSize.height ||
        widget.adSize.width != oldWidget.adSize.width) {
      _bannerAd?.dispose();
      setState(() => _bannerAd = null);
      _loadAd();
    }
  }

  /// Loads a banner ad
  void _loadAd() {
    if (!Platform.isAndroid && !Platform.isIOS) {
      debugPrint("Not show Ad because not Android or iOS");
      return;
    }

    String bannerUnitId = kDebugMode
        ? Platform.isAndroid
            ? 'ca-app-pub-3940256099942544/6300978111' // Test id on Android
            : 'ca-app-pub-3940256099942544/2934735716' // Test id on iOS
        : Platform.isAndroid
            // TODO replace with real unit ids
            ? 'ca-app-pub-3940256099942544/6300978111'
            : 'ca-app-pub-3940256099942544/2934735716';

    BannerAd(
      size: widget.adSize,
      adUnitId: bannerUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() => _bannerAd = ad as BannerAd);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: widget.adSize.width.toDouble(),
        height: widget.adSize.height.toDouble(),
        child: _bannerAd == null
            ? SizedBox() // Nothing to render yet.
            : AdWidget(ad: _bannerAd!),
      ),
    );
  }
}
