import 'package:mycrypto/app/core/repositories/auth_repository.dart';
import 'package:mycrypto/app/modules/auth/modules/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/auth/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/auth/modules/login/pages/reset_password_page.dart';
import 'package:mycrypto/app/modules/auth/modules/login/pages/send_mail_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => AuthRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
    ChildRoute('/reset_password', child: (_, args) => ResetPasswordPage()),
    ChildRoute('/send_mail', child: (_, args) => SendMailPage()),
  ];
}
