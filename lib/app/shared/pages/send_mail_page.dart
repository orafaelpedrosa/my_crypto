import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycrypto/app/shared/widgets/app_bar_widget.dart';

import 'package:mycrypto/app/shared/widgets/button/button_secondary_widget.dart';

class SendMailPage extends StatefulWidget {
  final String message;
  SendMailPage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<SendMailPage> createState() => _SendMailPageState();
}

class _SendMailPageState extends State<SendMailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(
        visibleTitle: false,
        showLeading: false,
      ).build(context) as AppBar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'E-mail enviado!',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Text(
                widget.message,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black54),
              ),
              SizedBox(height: 40),
              SvgPicture.asset(
                'assets/login/send_mail.svg',
                width: 250,
                height: 250,
                placeholderBuilder: (context) => Container(
                  height: 100,
                  width: 100,
                  child: const CircularProgressIndicator(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Se você não recebeu o e-mail, verifique sua caixa de Spam.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black54),
              ),
              SizedBox(height: 30),
              ButtonSecondaryWidget(
                text: 'Continuar',
                onPressed: () {
                  Modular.to.popUntil(ModalRoute.withName('/login/'));
                },
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
