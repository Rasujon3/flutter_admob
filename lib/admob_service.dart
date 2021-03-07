import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String get bannerAdUnitId => Platform.isAndroid ?
      'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';
  static String get iOsIntersttitialAdUnitID => Platform.isAndroid ?
      'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/1033173712';

  static InterstitialAd _interstitialAd;

  static initialize(){
    if(MobileAds.instance == null){
      MobileAds.instance.initialize();
  }
  }

  static BannerAd createBannerAd(){
    BannerAd ad = new BannerAd(
        size: AdSize.banner,
        adUnitId: bannerAdUnitId,
        listener: AdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded'),
          onAdFailedToLoad: (Ad ad, LoadAdError error){
            ad.dispose();
          },
          onAdOpened: (Ad ad) => print('Ad open'),
          onAdClosed: (Ad ad) => print('Ad close'),
        ),
        request: AdRequest(),);
    return ad;
  }

  static InterstitialAd _CreateInterstitialAd(){
    return InterstitialAd(
        adUnitId: iOsIntersttitialAdUnitID,
        request: AdRequest(),
        listener: AdListener(
          onAdLoaded: (Ad ad) => {_interstitialAd.show()},
          onAdFailedToLoad: (Ad ad, LoadAdError error){
            print('Ad failed to load: $error');
          },
          onAdOpened: (Ad ad) => print('Ad opened.'),
          onAdClosed: (Ad ad) => {_interstitialAd.dispose()},
          onApplicationExit: (Ad ad) => {_interstitialAd.dispose()},
        ),
        );
  }

  static void showInterstitialAd(){
    _interstitialAd?.dispose();
    _interstitialAd = null;

    if(_interstitialAd == null) {
      _interstitialAd = _CreateInterstitialAd();
    }
    _interstitialAd.load();
  }

}