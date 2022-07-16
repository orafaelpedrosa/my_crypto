import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycrypto/app/core/utils/validation.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
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
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool validateFormLogin = false;

  Validation _validation = Validation();

  @override
  void initState() {
    email.text = 'orafaelpedrosa@outlook.com';
    password.text = 'aezakmi';
    super.initState();
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
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(
                  parent: NeverScrollableScrollPhysics(),
                ),
                child: Column(
                  children: [
                    _buildHeaderLoginPage,
                    _buildFormLoginPage,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildHeaderLoginPage {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.065),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.020),
          SvgPicture.asset(
            'assets/app/logo.svg',
            height: 70,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SvgPicture.asset(
            'assets/app/mycrypto.svg',
            color: Colors.white,
            height: 35,
          ),
        ],
      ),
    );
  }

  Widget get _buildFormLoginPage {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 15),
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(4, 7),
          ),
        ],
      ),
      child: TripleBuilder(
        store: _store,
        builder: (_, triple) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 30,
                        color: Colors.black54,
                      ),
                ),
                const SizedBox(height: 30),
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
                  iconData: Icons.email_rounded,
                  label: 'E-mail',
                  hintText: 'E-mail',
                  enableSuggestions: false,
                ),
                const SizedBox(height: 20),
                TripleBuilder<ObscureStore, Exception, bool>(
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
                      iconData: Icons.lock,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _store.obscureStore.state
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColor,
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
                      );
                    },
                    child: Text(
                      'Esqueceu a senha?',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.black54,
                          ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 50,
                        duration: Duration(seconds: 1),
                        successColor: Theme.of(context).primaryColor,
                        errorColor: Colors.red,
                        successIcon: Icons.check_circle_outline,
                        animateOnTap: validateFormLogin,
                        borderRadius: 15,
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        controller: _btnController1,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            _store.state.email = email.text;
                            _store.state.password = password.text;
                            await _store
                                .authLogin(_store.state)
                                .whenComplete(() async {
                              if (_store.userCurrent != null) {
                                _btnController1.success();
                                await Future.delayed(
                                  Duration(seconds: 1),
                                  () =>
                                      Modular.to.pushNamed('/cryptocurrency/'),
                                );
                              }
                            }).catchError(
                              (error) async {
                                await openErrorSnackBar(
                                    context, "${error.message}");
                                _store.state.password = null;
                                _store.updateForm(_store.state);
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
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black54,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Cadastre-se',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Modular.to.pushNamed(
                              '/register_module/',
                            );
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor.withOpacity(0.65),
                    onPrimary: Theme.of(context).primaryColor,
                    minimumSize: Size(double.infinity, 50),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _store.authGoogle();
                    log('Google');
                  },
                  label: Text(
                    'Entrar com Google',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
