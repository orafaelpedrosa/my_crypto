import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:mycrypto/app/modules/auth/modules/login/stores/login_store.dart';
import 'package:mycrypto/app/modules/auth/modules/login/stores/obscure_store.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore> {
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  final Uri _url = Uri.parse('https://nomics.com');

  bool validateFormLogin = false;

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  void initState() {
    email.text = 'abc@gmail.com';
    password.text = '123456';
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
      height: MediaQuery.of(context).size.height * 0.7,
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
        store: store,
        builder: (_, triple) {
          return Form(
            key: formKey,
            child: Column(
              children: <Widget>[
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
                    store.state.email = input;
                    store.updateForm(store.state);
                  },
                  onSubmitted: (String? input) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe o email';
                    } else if (!(isEmail(value))) {
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
                  store: store.obscureStore,
                  builder: (_, obscureStore) {
                    return TextFormFieldWidget(
                      focusNode: passwordFocus,
                      textInputAction: TextInputAction.done,
                      controller: password,
                      onChange: (String? input) {
                        store.state.password = input;
                        store.updateForm(store.state);
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
                      obscureText: store.obscureStore.state,
                      iconData: Icons.lock,
                      suffixIcon: IconButton(
                        icon: Icon(
                          store.obscureStore.state
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          store.obscurePassword();
                        },
                      ),
                      label: 'Senha',
                      hintText: 'Senha',
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(top: 20),
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
                            // await store
                            //     .authLogin(store.state)
                            //     .catchError((e) {});
                            await store
                                .authLogin(store.state)
                                .whenComplete(() async {
                              _btnController1.success();
                              await Future.delayed(
                                Duration(seconds: 1),
                                () => Modular.to
                                    .pushReplacementNamed('crypto_module/'),
                              );
                            }).catchError(
                              (error) {
                                password.clear();
                                store.state.password = null;
                                store.updateForm(store.state);
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
                TextButton(
                  onPressed: () {
                    Modular.to.pushNamed(
                      'login_module/reset_password',
                    );
                  },
                  child: Text(
                    'Esqueceu a senha?',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ),
                const SizedBox(height: 15),
                TextButton(
                  child: Text(
                    'Crypto Market Cap & Pricing Data Provided\nBy Nomics',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    _launchUrl();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
