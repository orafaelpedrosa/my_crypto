import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mycrypto/app/core/utils/validation.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/obscure_store.dart';
import 'package:mycrypto/app/core/user_store.dart';
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

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  TextEditingController password = TextEditingController();
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/login/login.svg',
            height: MediaQuery.of(context).size.height * 0.25,
            placeholderBuilder: (context) => Container(
              height: 50,
              width: 50,
              child: const CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 15),
          SvgPicture.asset(
            'assets/app/mycrypto.svg',
            height: MediaQuery.of(context).size.height * 0.05,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 30),
          TripleBuilder(
            store: _store,
            builder: (_, triple) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
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
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
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
                          iconData: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
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
                            arguments: email.text,
                          );
                        },
                        child: Text(
                          'Esqueceu a senha?',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black87,
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                            controller: _btnController1,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                _store.state.email = email.text;
                                _store.state.password = password.text;
                                await _store
                                    .authLogin(_store.state)
                                    .then((value) async {
                                  if (!_userStore.user!.emailVerified) {
                                    _userStore.user ??
                                        _userStore.user!
                                            .sendEmailVerification();
                                    openWarningSnackBar(
                                      context,
                                      'Verifique seu e-mail para continuar',
                                    );

                                    // await _store.authLogout();
                                    _btnController1.reset();
                                  } else if (_userStore.user != null &&
                                      _userStore.user!.emailVerified) {
                                    _btnController1.success();
                                    await Future.delayed(
                                      Duration(seconds: 1),
                                      () async {
                                        Modular.to.pushNamed('/home/');
                                      },
                                    );
                                    Future.delayed(
                                      Duration(seconds: 5),
                                      () async {
                                        _btnController1.reset();
                                      },
                                    );
                                  }
                                }).catchError(
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
                              color: Colors.black87,
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
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        foregroundColor: Theme.of(context).primaryColor,
                        minimumSize: Size(double.infinity, 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        _store.authGoogle().then((value) async {
                          if (_userStore.user != null &&
                              _userStore.user!.emailVerified) {
                            await Future.delayed(
                              Duration(seconds: 1),
                              () => Modular.to.pushNamed('/home/'),
                            );
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
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
