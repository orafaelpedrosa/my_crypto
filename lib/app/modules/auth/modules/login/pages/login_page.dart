import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:mycrypto/app/core/theme/colors.dart';
import 'package:mycrypto/app/modules/auth/modules/login/login_store.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
  final formKey = GlobalKey<FormState>();
  bool validateFormLogin = false;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void login() {
    FocusScope.of(context).requestFocus(FocusNode());
    store.authLogin(store.state).then((value) {
      _btnController1.success();
    }).catchError((error) {
      password.clear();
      store.state.password = null;
      store.updateForm(store.state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: SvgPicture.asset(
              'assets/app/logo.svg',
              height: 70,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
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
      padding: const EdgeInsets.all(25),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(4, 7),
            // changes position of shadow
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
                  controller: email,
                  onChange: (String? input) {
                    store.state.email = input;
                    store.updateForm(store.state);
                  },
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe o email';
                    } else if (!value.contains('@')) {
                      return 'Por favor, informe um email válido';
                    } else {
                      validateFormLogin = true;
                      return null;
                    }
                  },
                  iconData: Icons.email_rounded,
                  labelText: 'E-mail',
                  hintText: 'E-mail',
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: password,
                  onChange: (String? input) {
                    store.state.password = input;
                    store.updateForm(store.state);
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
                  obscureText: true,
                  iconData: Icons.lock,
                  labelText: 'Senha',
                  hintText: 'Senha',
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
                        successColor: AppColors.primaryColor,
                        errorColor: Colors.red,
                        successIcon: Icons.check_circle_outline,
                        animateOnTap: validateFormLogin,
                        borderRadius: 15,
                        color: AppColors.primaryColor,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
