/*
Equivalent to OAuth provider registry.

Responsibilities:

Register providers
Enable / disable providers
Support hot swapping

Example logic (conceptual):
Google enabled
Meta disabled
Promo always enabled
*/

import 'ads_types.dart';
import 'providers/ad_provider.dart';

class AdsRegistry {
  final Map<AdProviderType, AdProvider> _providers = {};

  void register(AdProvider provider) {
    _providers[provider.type] = provider;
  }

  void unregister(AdProviderType type) {
    _providers.remove(type);
  }

  bool isRegistered(AdProviderType type) {
    return _providers.containsKey(type);
  }

  AdProvider getProvider(AdProviderType type) {
    final provider = _providers[type];
    if (provider == null) {
      throw Exception('AdProvider not registered: $type');
    }
    return provider;
  }
}
