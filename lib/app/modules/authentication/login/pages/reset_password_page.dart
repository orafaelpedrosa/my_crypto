import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycrypto/app/shared/widgets/snackbar/snackbar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:mycrypto/app/core/utils/validation.dart';
import 'package:mycrypto/app/modules/authentication/login/stores/login_store.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? email;
  ResetPasswordPage({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final LoginStore _store = Modular.get();
  TextEditingController resetPassword = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final formKey = GlobalKey<FormState>();
  bool validateFormReset = false;
  Validation validation = Validation();

  @override
  void initState() {
    if (widget.email != null || widget.email != '') {
      resetPassword.text = widget.email!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                'Não se preocupe, vamos te ajudar!\nInsira seu e-mail abaixo para que possamos enviar um link para você redefinir sua senha.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black54),
              ),
              SvgPicture.asset(
                'assets/login/reset_password.svg',
                width: 250,
                height: 250,
                placeholderBuilder: (context) => Container(
                  height: 100,
                  width: 100,
                  child: const CircularProgressIndicator(),
                ),
              ),
              Form(
                key: formKey,
                child: TextFormFieldWidget(
                  controller: resetPassword,
                  hintText: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  iconData: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe o email';
                    } else if (!(validation.isEmail(value))) {
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
                    await _store
                        .resetPassword(resetPassword.text)
                        .then((value) async {
                      _btnController1.success();
                      await Future.delayed(
                        Duration(seconds: 1),
                      );
                      Modular.to.pushNamed(
                        'send_mail',
                        arguments:
                            'Verifique sua Caixa de Entrada\ne clique no link para redefinir sua senha.',
                      );
                    }).catchError((e) async {
                      _btnController1.error();
                      await Future.delayed(
                        Duration(seconds: 1),
                      );
                      await openErrorSnackBar(
                        context,
                        e.message,
                      );
                      _btnController1.reset();
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
      ),
    );
  }
}
