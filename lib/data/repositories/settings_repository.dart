import 'package:bl_inshort/data/models/feeds/language_entity.dart';

abstract class SettingsRepository {
  Future<LanguageEntity?> getSelectedLanguage();
  Future<void> setSelectedLanguage(LanguageEntity language);
  Future<void> setAutoplay(bool enabled);
  Future<void> setHdImages(bool enabled);
  Future<bool> isAutoplayEnabled();
  Future<bool> isHdImagesEnabled();
}

class InMemorySettingsRepository implements SettingsRepository {
  LanguageEntity? _language;
  bool _autoplayEnabled = true;
  bool _hdImagesEnabled = true;

  @override
  Future<LanguageEntity?> getSelectedLanguage() async {
    return _language;
  }

  @override
  Future<void> setSelectedLanguage(LanguageEntity language) async {
    _language = language;
  }

  @override
  Future<void> setAutoplay(bool enabled) async {
    // In-memory implementation does nothing
    _autoplayEnabled = enabled;
  }

  @override
  Future<void> setHdImages(bool enabled) async {
    // In-memory implementation does nothing
    _hdImagesEnabled = enabled;
  }

  @override
  Future<bool> isAutoplayEnabled() async {
    return _autoplayEnabled;
  }

  @override
  Future<bool> isHdImagesEnabled() async {
    return _hdImagesEnabled;
  }
}
