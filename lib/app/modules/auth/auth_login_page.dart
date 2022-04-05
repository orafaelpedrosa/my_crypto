import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mycrypto/app/core/theme/colors.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({Key? key}) : super(key: key);

  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
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
                child: Column(
                  children: <Widget>[
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 30,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30.0,
                      ),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                            ),
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                            color: AppColors.primaryColor.withOpacity(0.5),
                          ),
                          hintText: 'E-mail',
                          hintStyle: TextStyle(
                            color: AppColors.primaryColor.withOpacity(0.5),
                          ),
                          prefixIcon: Icon(
                            Icons.mail_rounded,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(35),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(35),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextField(
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                            ),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                            color: AppColors.primaryColor.withOpacity(0.5),
                          ),
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                            color: AppColors.primaryColor.withOpacity(0.5),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(35),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(35),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.primaryColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.only(top: 20),
                      child: RoundedLoadingButton(
                        animateOnTap: false,
                        borderRadius: 35,
                        color: AppColors.primaryColor,
                        child: Text(
                          'Login',
                          style:
                              Theme.of(context).textTheme.headline1!.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                        ),
                        controller: _btnController1,
                        onPressed: () {
                          Modular.to.pushReplacementNamed('crypto_module/');
                          log('Button Pressed');
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
