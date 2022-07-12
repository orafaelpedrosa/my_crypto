import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mycrypto/app/core/utils/validation.dart';
import 'package:mycrypto/app/modules/authentication/register/stores/register_store.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class FirstFormRegisterWidget extends StatefulWidget {
  final PageController pageController;

  const FirstFormRegisterWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  State<FirstFormRegisterWidget> createState() =>
      _FirstFormRegisterWidgetState();
}

class _FirstFormRegisterWidgetState extends State<FirstFormRegisterWidget> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final formKey = GlobalKey<FormState>();
  Validation _validation = Validation();
  RegisterStore _registerStore = Modular.get<RegisterStore>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: _nameController,
            label: 'Nome completo',
            hintText: 'Digite seu nome',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Digite seu nome';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormFieldWidget(
            controller: _emailController,
            label: 'Email',
            hintText: 'Digite seu email',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Digite seu email';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormFieldWidget(
            obscureText: true,
            controller: _passwordController,
            label: 'Senha',
            hintText: 'Digite seu email',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Digite seu email';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          TextFormFieldWidget(
            obscureText: true,
            controller: _confirmPasswordController,
            label: 'Confirmar senha',
            hintText: 'Digite seu email',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Digite seu email';
              }
              return null;
            },
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
                  animateOnTap: (_validation.isEmail(_emailController.text) &&
                      _validation.isEmail(_emailController.text)),
                  borderRadius: 15,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  controller: _btnController1,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      log('Formulário validado');
                      _registerStore.state.email = _emailController.text;
                      _registerStore.state.password = _passwordController.text;
                      _registerStore
                          .authRegister(_registerStore.state)
                          .then((value) {
                        Modular.to.pushReplacementNamed('/auth');
                      }).catchError((error) {
                        log(error);
                      });
                    } else {
                      _btnController1.error();
                      _btnController1.reset();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
