import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/core/utils/validation.dart';
import 'package:mycrypto/app/modules/authentication/register/stores/register_store.dart';
import 'package:mycrypto/app/shared/widgets/snackbar/snackbar.dart';
import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'RegisterPage'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  RegisterStore _registerStore = Modular.get<RegisterStore>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Validation _validation = Validation();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cadastre-se',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/login/register.svg',
                height: 175,
              ),
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      iconData: Icon(
                        Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
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
                    SizedBox(height: 15),
                    TextFormFieldWidget(
                      controller: _emailController,
                      iconData: Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      label: 'Email',
                      hintText: 'Digite seu email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite seu email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormFieldWidget(
                      obscureText: true,
                      controller: _passwordController,
                      iconData: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      label: 'Senha',
                      hintText: 'Senha',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Digite sua senha';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormFieldWidget(
                      obscureText: true,
                      controller: _confirmPasswordController,
                      iconData: Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                      label: 'Confirme sua senha',
                      hintText: 'Confirme sua senha',
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Confirme sua senha';
                        }
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          return "As senhas não conferem";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedLoadingButton(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 50,
                          duration: Duration(seconds: 1),
                          successColor: Theme.of(context).primaryColor,
                          errorColor: Colors.red,
                          successIcon: Icons.check_circle_outline,
                          animateOnTap:
                              (_validation.isEmail(_emailController.text) &&
                                  _validation.isEmail(_emailController.text)),
                          borderRadius: 15,
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Cadastrar',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          controller: _btnController1,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _registerStore.state.password =
                                  _passwordController.text;
                              _registerStore.state.email =
                                  _emailController.text;
                              _registerStore
                                  .authRegister(_registerStore.state)
                                  .then((value) async {
                                _btnController1.success();
                                Modular.to.pushNamed(
                                  'send_mail',
                                  arguments:
                                      'Enviamos um email para ${_registerStore.state.email} para que você possa confirmar seu cadastro!',
                                );
                              }).catchError(
                                (error) async {
                                  await openErrorSnackBar(
                                      context, "${error.message}");
                                  _registerStore.state.password = null;
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
