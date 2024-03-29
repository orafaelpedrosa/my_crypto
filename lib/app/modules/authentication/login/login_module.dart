import 'package:mycrypto/app/modules/authentication/auth_check_store.dart';
import 'package:mycrypto/app/modules/authentication/login/login_repository.dart';
import 'package:mycrypto/app/modules/authentication/login/pages/login_page.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/modules/authentication/login/pages/reset_password_page.dart';
import 'package:mycrypto/app/shared/pages/send_mail_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ObscureStore()),
    Bind.lazySingleton((i) => LoginStore()),
    Bind.lazySingleton((i) => LoginRepository()),
    Bind.lazySingleton((i) => AuthCheckStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const LoginPage()),
    ChildRoute('/reset_password',
        child: (_, args) => ResetPasswordPage(email: args.data)),
    ChildRoute('/send_mail',
        child: (_, args) => SendMailPage(message: args.data)),
  ];
}
