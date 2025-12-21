import 'package:bl_inshort/data/models/settings/language_entity.dart';
import 'package:bl_inshort/data/repositories/settings_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

enum InterestPreference {
  interested,
  notInterested,
  neutral,
}

class SettingsState {
  final LanguageEntity? selectedLanguage;
  final bool autoplayEnabled;
  final bool hdImagesEnabled;
  final Map<String, InterestPreference> interests;

  const SettingsState({
    this.selectedLanguage,
    this.autoplayEnabled = true,
    this.hdImagesEnabled = true,
    this.interests = const {},
  });

  SettingsState copyWith({
    LanguageEntity? selectedLanguage,
    bool? autoplayEnabled,
    bool? hdImagesEnabled,
    Map<String, InterestPreference>? interests,
  }) {
    return SettingsState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      autoplayEnabled: autoplayEnabled ?? this.autoplayEnabled,
      hdImagesEnabled: hdImagesEnabled ?? this.hdImagesEnabled,
      interests: interests ?? this.interests,
    );
  }
}


class SettingsController extends StateNotifier<SettingsState> {
  final SettingsRepository repository;

  SettingsController(this.repository)
      : super(const SettingsState()) {
    _load();
  }

  Future<void> _load() async {
    final lang = await repository.getSelectedLanguage();
    final autoplay = await repository.isAutoplayEnabled();
    final hdImages = await repository.isHdImagesEnabled();

    state = state.copyWith(selectedLanguage: lang, autoplayEnabled: autoplay, hdImagesEnabled: hdImages);
  }

  // 🔹 Language
  Future<void> selectLanguage(LanguageEntity language) async {
    await repository.setSelectedLanguage(language);
    state = state.copyWith(selectedLanguage: language);
  }

  // 🔹 Autoplay
  Future<void> setAutoplay(bool enabled) async {
    await repository.setAutoplay(enabled);
    state = state.copyWith(autoplayEnabled: enabled);
  }

  // 🔹 HD Images
  Future<void> setHdImages(bool enabled) async {
    await repository.setHdImages(enabled);
    state = state.copyWith(hdImagesEnabled: enabled);
  }

  // 🔹 Content Interest
  void setInterest(String topic, InterestPreference preference) {
    final updated = Map<String, InterestPreference>.from(state.interests);
    updated[topic] = preference;

    state = state.copyWith(interests: updated);
  }
}