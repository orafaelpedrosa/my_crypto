import 'dart:developer';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (Ad ad) => log('Ad loaded: ${ad.adUnitId}.'),
    onAdFailedToLoad: (ad, error) => log('Ad failed to load: $error'),
    onAdOpened: (Ad ad) => log('Ad opened: ${ad.adUnitId}.'),
    onAdClosed: (ad) => ad.dispose(),
  );
}
