import 'package:mycrypto/app/modules/profile/pages/profile_page.dart';
import 'package:mycrypto/app/modules/profile/pages/settings_page.dart';
import 'package:mycrypto/app/modules/profile/profile_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ProfileStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ProfilePage()),
    ChildRoute('/settings', child: (_, args) => SettingsPage()),
  ];
}
