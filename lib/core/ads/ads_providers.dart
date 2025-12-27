import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ads_registry.dart';
import 'ads_runtime.dart';
import 'providers/google/google_ads_provider.dart';
import 'providers/promo/promo_ads_provider.dart';

/// Registry Provider
final adsRegistryProvider = Provider<AdsRegistry>((ref) {
  final registry = AdsRegistry()
    ..register(GoogleAdsProvider())
    ..register(PromoAdsProvider());

  return registry;
});

/// Runtime Provider (what UI will use)
final adsRuntimeProvider = Provider<AdsRuntime>((ref) {
  final registry = ref.watch(adsRegistryProvider);
  return AdsRuntime(registry);
});
