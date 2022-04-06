import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mycrypto/app/core/theme/colors.dart';
import 'package:mycrypto/app/modules/auth/stores/auth_check_store.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({Key? key}) : super(key: key);

  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  ScrollController _scrollController = ScrollController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLogin = true;
  late String title;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    setFormAction(true);

    super.initState();
  }

  setFormAction(bool action) {
    setState(
      () {
        isLogin = action;
        title = isLogin ? 'Bem-vindo' : 'Registre-se';
        actionButton = isLogin ? 'Login' : 'Registrar';
        toggleButton = isLogin
            ? 'Não tem conta? Registre-se agora'
            : 'Já possui conta? Faça login';
      },
    );
  }

  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthCheckStore authCheckStore = Modular.get();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          color: AppColors.primaryColor,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.075),
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
                      height: 40,
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
                      color: AppColors.primaryColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: const Offset(4, 7),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 30,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: TextFormFieldWidget(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
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
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormFieldWidget(
                          controller: password,
                          keyboardType: TextInputType.emailAddress,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedLoadingButton(
                              duration: Duration(seconds: 3),
                              animateOnTap: false,
                              borderRadius: 35,
                              color: AppColors.primaryColor,
                              child: Text(
                                actionButton,
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
                                /*Modular.to.pushReplacementNamed('crypto_module/');
                                log('Button Pressed');*/
                                if (formKey.currentState!.validate()) {
                                  isLogin
                                      ? await authCheckStore.authLogin(
                                          email.text,
                                          password.text,
                                        )
                                      : await authCheckStore.authRegister(
                                          email.text,
                                          password.text,
                                        );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setFormAction(!isLogin);
                          email.clear();
                          password.clear();
                        },
                        child: Text(
                          toggleButton,
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
