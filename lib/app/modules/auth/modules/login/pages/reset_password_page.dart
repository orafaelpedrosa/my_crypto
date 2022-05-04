import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycrypto/app/modules/auth/modules/login/stores/login_store.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState
    extends ModularState<ResetPasswordPage, LoginStore> {
  TextEditingController resetPassword = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final formKey = GlobalKey<FormState>();
  bool validateFormReset = false;

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Esqueceu sua senha ?',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Text(
                'Não se preocupe, vamos te ajudar!\nInsira seu e-mail abaixo para \nredefinir sua senha.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black54),
              ),
              SvgPicture.asset(
                'assets/login/reset_password.svg',
                width: 300,
                height: 300,
              ),
              Form(
                key: formKey,
                child: TextFormFieldWidget(
                  controller: resetPassword,
                  hintText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  iconData: Icons.email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe o email';
                    } else if (!(isEmail(value))) {
                      return 'Por favor, informe um email válido';
                    } else {
                      validateFormReset = true;
                      return null;
                    }
                  },
                  enableSuggestions: false,
                ),
              ),
              SizedBox(height: 20),
              RoundedLoadingButton(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 50,
                duration: Duration(seconds: 1),
                successColor: Theme.of(context).primaryColor,
                errorColor: Colors.red,
                successIcon: Icons.check_circle_outline,
                animateOnTap: validateFormReset,
                borderRadius: 15,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Enviar',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                      ),
                ),
                controller: _btnController1,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await store.resetPassword(resetPassword.text);
                    _btnController1.success();
                    await Future.delayed(
                      Duration(seconds: 1),
                    );
                    Modular.to.pushNamed(
                      'send_mail',
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
      ),
    );
  }
}
