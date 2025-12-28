/*
  Centralized ad analytics.

    Why separate?
    Google ≠ Meta metrics
    Feed analytics must remain clean
    Ads failures must be visible

    This file translates:
    provider events → analytics_client
*/

import 'package:bl_inshort/core/ads/ads_types.dart';

class AdsAnalytics {
  void adRequested(AdMeta meta) {}
  void adLoaded(AdMeta meta) {}
  void adFailed(AdMeta meta) {}
  void fallbackShown(AdMeta meta) {}
}
