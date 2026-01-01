import 'package:bl_inshort/data/models/feeds/language_entity.dart';
import 'package:bl_inshort/data/repositories/settings_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

enum InterestPreference { interested, notInterested, neutral }

class SettingsState {
  final LanguageEntity? selectedLanguage;
  final bool autoplayEnabled;
  final bool hdImagesEnabled;
  final Map<String, InterestPreference> interests;
  final bool isInitialized; // ✅ NEW

  /// NEW
  final Set<String> selectedRegions;

  const SettingsState({
    this.selectedLanguage,
    this.autoplayEnabled = true,
    this.hdImagesEnabled = true,
    this.interests = const {},
    this.selectedRegions = const {},
    this.isInitialized = false,
  });

  SettingsState copyWith({
    LanguageEntity? selectedLanguage,
    bool? autoplayEnabled,
    bool? hdImagesEnabled,
    Map<String, InterestPreference>? interests,
    Set<String>? selectedRegions,
    bool? isInitialized,
  }) {
    return SettingsState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      autoplayEnabled: autoplayEnabled ?? this.autoplayEnabled,
      hdImagesEnabled: hdImagesEnabled ?? this.hdImagesEnabled,
      interests: interests ?? this.interests,
      selectedRegions: selectedRegions ?? this.selectedRegions,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  final SettingsRepository repository;

  SettingsController(this.repository) : super(const SettingsState()) {
    _load();
  }

  Future<void> _load() async {
    final lang = await repository.getSelectedLanguage();
    final autoplay = await repository.isAutoplayEnabled();
    final hdImages = await repository.isHdImagesEnabled();
    final regions = await repository.getSelectedRegions();

    state = state.copyWith(
      selectedLanguage: lang,
      autoplayEnabled: autoplay,
      hdImagesEnabled: hdImages,
      selectedRegions: regions,
      isInitialized: true, // ✅
    );
  }

  // 🔹 Language
  Future<void> selectLanguage(LanguageEntity language) async {
    await repository.setSelectedLanguage(language);
    state = state.copyWith(selectedLanguage: language);
  }

  Future<void> setSelectedRegions(Set<String> regions) async {
    await repository.setSelectedRegions(regions);
    state = state.copyWith(selectedRegions: regions);
  }

  // 🔹 Regions
  Future<void> toggleRegion(String region) async {
    final updated = Set<String>.from(state.selectedRegions);

    if (updated.contains(region)) {
      updated.remove(region);
    } else {
      updated.add(region);
    }

    await repository.setSelectedRegions(updated);
    state = state.copyWith(selectedRegions: updated);
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

  bool isRegionSelected(String region) {
    return state.selectedRegions.contains(region);
  }

  bool get hasCompletedOnboarding =>
      state.selectedLanguage != null && state.selectedRegions.isNotEmpty;
}
