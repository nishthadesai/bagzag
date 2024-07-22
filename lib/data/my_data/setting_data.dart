import '../../generated/l10n.dart';

class SettingData {
  final String setting;

  SettingData({required this.setting});
}

List settingDataList = [
  SettingData(setting: S.current.notificationonoff),
  SettingData(setting: S.current.sharingSettings),
  SettingData(setting: S.current.clearHistory),
  SettingData(setting: S.current.closeAccount),
  SettingData(setting: S.current.changePassword),
  SettingData(setting: S.current.rateApp),
  SettingData(setting: S.current.shareApp),
  SettingData(setting: S.current.helpCenter),
  SettingData(setting: S.current.termsOfUse),
  SettingData(setting: S.current.privacyPolicy),
  SettingData(setting: S.current.aboutUs),
  SettingData(setting: S.current.contactUs),
];
