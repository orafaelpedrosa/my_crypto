import 'package:mycrypto/app/core/stores/use_biometric_store.dart';
import 'package:mycrypto/app/modules/profile/pages/profile_page.dart';
import 'package:mycrypto/app/modules/profile/pages/settings_page.dart';
import 'package:mycrypto/app/modules/profile/profile_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore()),
    Bind.lazySingleton((i) => UseBiometricStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProfilePage()),
    ChildRoute('/settings', child: (_, args) => SettingsPage()),
  ];
}
