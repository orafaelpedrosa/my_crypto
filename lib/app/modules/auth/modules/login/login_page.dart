import 'dart:async';
import 'dart:developer';

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

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 10), () {
      controller.success();
    });
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
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                      color: AppColors.primaryColor,
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.065),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/app/mycrypto_logo.svg',
                                  height: 100,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SvgPicture.asset(
                                  'assets/app/mycrypto.svg',
                                  height: 35,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(30.0),
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.5),
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                fontSize: 30,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 30.0,
                                          ),
                                          child: TextFormFieldWidget(
                                            controller: email,
                                            onChange: (String? input) {
                                              store.state.email = input;
                                              store.updateForm(store.state);
                                            },
                                            textCapitalization:
                                                TextCapitalization.none,
                                            //textInputAction: TextInputAction.next,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Por favor, informe o email';
                                              }
                                              return null;
                                            },
                                            iconData: Icons.email_rounded,
                                            labelText: 'E-mail',
                                            hintText: 'E-mail',
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: TextFormFieldWidget(
                                            controller: password,
                                            onChange: (String? input) {
                                              store.state.password = input;
                                              store.updateForm(store.state);
                                            },
                                            textCapitalization:
                                                TextCapitalization.none,
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
                                        ),
                                        Container(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.only(top: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              /*ButtonAuth(
                                                duration: Duration(seconds: 1),
                                                animateOnTap: true,
                                                borderRadius: 35,
                                                color: AppColors.primaryColor,
                                                text: 'Logiiiiiin',
                                                textColor: Colors.white,
                                                textSize: 16,
                                                onPressed: () async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    store
                                                        .authLogin(store.state);
                                                  }
                                                },
                                                controller: _btnController1,
                                              ),*/
                                              RoundedLoadingButton(
                                                  duration:
                                                      Duration(seconds: 10),
                                                  successIcon: Icons
                                                      .check_circle_outline,
                                                  animateOnTap: false,
                                                  borderRadius: 35,
                                                  color: AppColors.primaryColor,
                                                  child: Text(
                                                    'Login',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                  controller: _btnController1,
                                                  onPressed: () async {
                                                    await Future.delayed(
                                                        Duration(seconds: 2));
                                                    _btnController1.success();
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      store.authLogin(
                                                          store.state);
                                                      Modular.to
                                                          .pushReplacementNamed(
                                                              'crypto_module/');
                                                      log('Button Pressed');
                                                    }
                                                  }
                                                  /*onPressed: () async {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    _btnController1.success();
                                                    Timer(Duration(seconds: 3),
                                                        () {
                                                      store.authLogin(
                                                          store.state);
                                                      Modular.to
                                                          .pushReplacementNamed(
                                                              'crypto_module/');
                                                      log('Button Pressed');
                                                    });
                                                  }
                                                },*/
                                                  ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            store.resetPassword(store.state);
                                            email.clear();
                                            password.clear();
                                          },
                                          child: Text(
                                            'Esqueceu a senha?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
