import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/stores/use_biometric_store.dart';
import 'package:mycrypto/app/core/utils/validation.dart';
import 'package:mycrypto/app/modules/authentication/login/pages/permission_biometric_page.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/shared/widgets/snackbar/snackbar.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore _store = Modular.get();
  final UserStore _userStore = Modular.get();
  final UseBiometricStore _useBiometricStore = Modular.get();

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  TextEditingController password = TextEditingController();
  final FocusNode passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool validateFormLogin = true;
  Validation _validation = Validation();

  @override
  void initState() {
    super.initState();
    setState(() {
      email.text = 'orafaelpedrosa@outlook.com';
      password.text = 'teste@123';
    });
  }

  void dispose() {
    email.dispose();
    password.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(
                  parent: NeverScrollableScrollPhysics(),
                ),
                child: _buildFormLoginPage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildFormLoginPage {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/app/mycrypto.svg',
            color: Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).colorScheme.primary
                : null,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(height: 50),
          TripleBuilder(
            store: _store,
            builder: (_, triple) {
              return Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormFieldWidget(
                      focusNode: emailFocus,
                      textInputAction: TextInputAction.next,
                      controller: email,
                      onChange: (String? input) {
                        _store.state.email = input;
                        _store.updateForm(_store.state);
                      },
                      onSubmitted: (String? input) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, informe o email';
                        } else if (!_validation.isEmail(value)) {
                          return 'Por favor, informe um email válido';
                        } else {
                          validateFormLogin = true;
                          return null;
                        }
                      },
                      iconData: Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      label: 'E-mail',
                      hintText: 'E-mail',
                      enableSuggestions: false,
                    ),
                    const SizedBox(height: 20),
                    TripleBuilder<ObscureStore, bool>(
                      store: _store.obscureStore,
                      builder: (_, obscureStore) {
                        return TextFormFieldWidget(
                          focusNode: passwordFocus,
                          textInputAction: TextInputAction.done,
                          controller: password,
                          onChange: (String? input) {
                            _store.state.password = input;
                            _store.updateForm(_store.state);
                          },
                          onSubmitted: (String? input) {
                            FocusScope.of(context).unfocus();
                          },
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, informe a senha';
                            } else if (value.length < 6) {
                              return 'A senha deve conter no mínimo 6 caracteres';
                            }
                            return null;
                          },
                          obscureText: _store.obscureStore.state,
                          iconData: Icon(
                            Icons.lock,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _store.obscureStore.state
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            onPressed: () {
                              _store.obscurePassword();
                            },
                          ),
                          label: 'Senha',
                          hintText: 'Senha',
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Modular.to.pushNamed(
                            '/login/reset_password',
                            arguments: email.text,
                          );
                        },
                        child: Text(
                          'Esqueceu a senha?',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundedLoadingButton(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 50,
                            duration: Duration(seconds: 1),
                            successColor: Theme.of(context).colorScheme.primary,
                            errorColor: Colors.red,
                            successIcon: Icons.check_circle_outline,
                            animateOnTap: validateFormLogin,
                            borderRadius: 15,
                            color: Theme.of(context).colorScheme.primary,
                            child: Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            controller: _btnController1,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                _store.state.email = email.text;
                                _store.state.password = password.text;
                                await _store.authLogin(_store.state).then(
                                  (value) async {
                                    if (!_userStore.user!.emailVerified) {
                                      await _userStore.user!
                                          .sendEmailVerification();
                                      await openWarningSnackBar(
                                        context,
                                        'Verifique seu e-mail para continuar',
                                      );
                                      _btnController1.reset();
                                    } else {
                                      _btnController1.success();

                                      final isLocalAuthAvailable =
                                          await _useBiometricStore
                                              .isBiometricAvailable();

                                      final hasBiometricsAvailable =
                                          isLocalAuthAvailable &&
                                              await _useBiometricStore
                                                  .hasBiometricsAvailable();

                                      if (hasBiometricsAvailable &&
                                          (await _useBiometricStore
                                                  .getHasBiometrics()) ==
                                              UseBiometricPermissionEnum
                                                  .notAccepted) {
                                        await showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          enableDrag: false,
                                          builder: (context) {
                                            return PermissionBiometricPage();
                                          },
                                        );
                                      }
                                      await Future.delayed(
                                          Duration(seconds: 1));
                                      Modular.to.pushNamed(
                                        '/home/',
                                      );
                                    }
                                  },
                                ).catchError(
                                  (error) async {
                                    _store.state.email = null;
                                    _store.state.password = null;
                                    _store.updateForm(_store.state);
                                    _btnController1.error();
                                    await Future.delayed(
                                      Duration(seconds: 1),
                                    );
                                    await openErrorSnackBar(
                                      context,
                                      error.message,
                                    );
                                    _btnController1.reset();
                                  },
                                );
                              } else {
                                _btnController1.error();
                                _btnController1.reset();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: 'Não tem uma conta? ',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Cadastre-se',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Modular.to.pushNamed(
                                  '/register/',
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: Size(double.infinity, 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        _store.authGoogle().then((value) async {
                          if (_userStore.user != null &&
                              _userStore.user!.emailVerified) {
                            final isLocalAuthAvailable =
                                await _useBiometricStore.isBiometricAvailable();
                            final hasBiometricsAvailable =
                                isLocalAuthAvailable &&
                                    await _useBiometricStore
                                        .hasBiometricsAvailable();

                            if (hasBiometricsAvailable &&
                                (await _useBiometricStore.getHasBiometrics()) ==
                                    UseBiometricPermissionEnum.notAccepted) {
                              await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                enableDrag: false,
                                builder: (context) {
                                  return PermissionBiometricPage();
                                },
                              );
                            } else {
                              log('Login realizado com sucesso');
                              await Future.delayed(Duration(seconds: 1));
                              Modular.to.pushNamed('/home/');
                            }
                          }
                        }).catchError((error) async {
                          await openErrorSnackBar(
                            context,
                            error.message,
                          );
                        });
                      },
                      label: Text(
                        'Entrar com Google',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Text(
            'Dados fornecidos por:',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(
                        0.5,
                      ),
                  fontSize: 10,
                ),
          ),
          SizedBox(height: 5),
          SvgPicture.asset('assets/app/coin_gecko.svg',
              height: 20,
              color: Theme.of(context).colorScheme.secondary.withOpacity(
                    0.5,
                  )),
        ],
      ),
    );
  }
}
