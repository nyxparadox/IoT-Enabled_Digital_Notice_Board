import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/Data/Model/settings_model.dart';
import 'package:mobile_app/Data/Repository/settings_repository.dart';

class SettingsState {
  final SettingsModel? saved;
  final SettingsModel? draft;

  final bool loading;
  final bool saving;

  SettingsState({
    this.saved,
    this.draft,
    this.loading = false,
    this.saving = false,
  });

  bool get hasChanges =>
      saved != null && draft != null && saved != draft;
}

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsCubit ({required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super( SettingsState(loading: true)){
          loadSettings();

        }

  Future<void> loadSettings() async {
    final s = await _settingsRepository.fetchSettings();

    emit(SettingsState(saved: s, draft: s, loading: false));
  }

  void _updateDraft(SettingsModel updated) {
    emit(SettingsState(saved: state.saved, draft: updated));
  }

  void updateBrightness(double v) {
    _updateDraft(state.draft!.copyWith(brightness: v.toInt()));
  }

  void updateScrollSpeed(int v) {
    _updateDraft(state.draft!.copyWith(scrollSpeed: v));
  }

  void updateDisplayMode(String v) {
    _updateDraft(state.draft!.copyWith(displayMode: v));
  }

  void updateHeaderColor(String v) {
    _updateDraft(state.draft!.copyWith(headerTextColor: v));
  }

  void updateBodyColor(String v) {
    _updateDraft(state.draft!.copyWith(bodyTextColor: v));
  }

  void toggleBorder(bool v) {
    _updateDraft(state.draft!.copyWith(borderEnabled: v));
  }

  void updateBorderStyle(String v) {
    _updateDraft(state.draft!.copyWith(borderStyle: v));
  }

  void updateBorderColor(String v) {
    _updateDraft(state.draft!.copyWith(borderColor: v));
  }

  void increaseThickness() {
    _updateDraft(
      state.draft!.copyWith(borderThickness: state.draft!.borderThickness + 1),
    );
  }

  void decreaseThickness() {
    if (state.draft!.borderThickness <= 1) return;

    _updateDraft(
      state.draft!.copyWith(borderThickness: state.draft!.borderThickness - 1),
    );
  }

  Future<void> applyChanges() async {
    emit(SettingsState(saved: state.saved, draft: state.draft, saving: true));

    await _settingsRepository.updateSettings(state.draft!);

    emit(SettingsState(saved: state.draft, draft: state.draft, saving: false));
  }

  void discardChanges() {
    emit(SettingsState(saved: state.saved, draft: state.saved));
  }

  Future<void> reset() async {
    await _settingsRepository.sendCommand("resetDisplay");
  }

  Future<void> restart() async {
    await _settingsRepository.sendCommand("restartDevice");
  }

  Future<void> resetWifi() async {
    await _settingsRepository.sendCommand("resetWifi");
  }

  Future<void> sendWifiCredentials(String ssid, String password) async {
    await _settingsRepository.sendWifiCredentials(ssid, password);
  }
}
