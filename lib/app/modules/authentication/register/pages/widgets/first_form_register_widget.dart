// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:mycrypto/app/core/utils/validation.dart';
// import 'package:mycrypto/app/modules/authentication/register/stores/register_store.dart';
// import 'package:mycrypto/app/shared/widgets/snackbar/snackbar.dart';
// import 'package:mycrypto/app/shared/widgets/text_field/text_form_field_widget.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';

// class FirstFormRegisterWidget extends StatefulWidget {
//   final PageController pageController;

//   const FirstFormRegisterWidget({
//     Key? key,
//     required this.pageController,
//   }) : super(key: key);

//   @override
//   State<FirstFormRegisterWidget> createState() =>
//       _FirstFormRegisterWidgetState();
// }

// class _FirstFormRegisterWidgetState extends State<FirstFormRegisterWidget> {

//   RegisterStore _registerStore = Modular.get<RegisterStore>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         physics: ClampingScrollPhysics(
//           parent: NeverScrollableScrollPhysics(),
//         ),
//         child: Column(
//           children: [
//             TextFormFieldWidget(
//               iconData: Icon(
//                 Icons.person_outline,
//                 color: Theme.of(context).primaryColor,
//                 size: 20,
//               ),
//               controller: _nameController,
//               label: 'Nome completo',
//               hintText: 'Digite seu nome',
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Digite seu nome';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 15),
//             TextFormFieldWidget(
//               controller: _emailController,
//               iconData: Icon(
//                 Icons.email_outlined,
//                 color: Theme.of(context).primaryColor,
//                 size: 20,
//               ),
//               label: 'Email',
//               hintText: 'Digite seu email',
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Digite seu email';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 15),
//             TextFormFieldWidget(
//               obscureText: true,
//               controller: _passwordController,
//               iconData: Icon(
//                 Icons.lock_outline,
//                 color: Theme.of(context).primaryColor,
//                 size: 20,
//               ),
//               label: 'Senha',
//               hintText: 'Senha',
//               validator: (String? value) {
//                 if (value!.isEmpty) {
//                   return 'Digite sua senha';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 15),
//             TextFormFieldWidget(
//               obscureText: true,
//               controller: _confirmPasswordController,
//               iconData: Icon(
//                 Icons.lock_outline,
//                 color: Theme.of(context).primaryColor,
//                 size: 20,
//               ),
//               label: 'Confirme sua senha',
//               hintText: 'Confirme sua senha',
//               validator: (String? value) {
//                 if (value!.isEmpty) {
//                   return 'Confirme sua senha';
//                 }
//                 if (_passwordController.text !=
//                     _confirmPasswordController.text) {
//                   return "As senhas não conferem";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 15),
//             Container(
//               padding: EdgeInsets.zero,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: RoundedLoadingButton(
//                       // width: MediaQuery.of(context).size.width * 0.85,
//                       height: 50,
//                       duration: Duration(seconds: 1),
//                       successColor: Theme.of(context).primaryColor,
//                       errorColor: Colors.red,
//                       successIcon: Icons.check_circle_outline,
//                       animateOnTap:
//                           (_validation.isEmail(_emailController.text) &&
//                               _validation.isEmail(_emailController.text)),
//                       borderRadius: 15,
//                       color: Theme.of(context).primaryColor,
//                       child: Text(
//                         'Cadastrar',
//                         style: Theme.of(context).textTheme.headline4!.copyWith(
//                               color: Colors.white,
//                             ),
//                       ),
//                       controller: _btnController1,
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           _registerStore.state.password =
//                               _passwordController.text;
//                           _registerStore.state.email = _emailController.text;
//                           _registerStore
//                               .authRegister(_registerStore.state)
//                               .whenComplete(() async {
//                             _btnController1.success();
//                             Modular.to.pushNamed(
//                               'send_mail',
//                               arguments:
//                                   'Enviamos um email para ${_registerStore.state.email} para que possa confirmar seu cadastro!',
//                             );
//                           }).catchError(
//                             (error) async {
//                               await openErrorSnackBar(
//                                   context, "${error.message}");
//                               _registerStore.state.password = null;
//                               _btnController1.reset();
//                             },
//                           );
//                         } else {
//                           _btnController1.error();
//                           _btnController1.reset();
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
