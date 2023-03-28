enum ThemeModeEnum {
  light,
  dark,
  system,
}

extension ThemeModeExtension on ThemeModeEnum {
  String get label {
    switch (this) {
      case ThemeModeEnum.light:
        return 'light';
      case ThemeModeEnum.dark:
        return 'dark';
      case ThemeModeEnum.system:
        return 'system';
      default:
        return toString();
    }
  }
}

ThemeModeEnum? useThemeModeFromDevice(String? permission) {
  switch (permission) {
    case 'light':
      return ThemeModeEnum.light;
    case 'dark':
      return ThemeModeEnum.dark;
    case 'system':
      return ThemeModeEnum.system;
    default:
      return ThemeModeEnum.dark;
  }
}

String useThemeModeFromJson(ThemeModeEnum? permission) {
  switch (permission) {
    case ThemeModeEnum.light:
      return 'light';
    case ThemeModeEnum.dark:
      return 'dark';
    case ThemeModeEnum.system:
      return 'system';
    default:
      return 'dark';
  }
}
