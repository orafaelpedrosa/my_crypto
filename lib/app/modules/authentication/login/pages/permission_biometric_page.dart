import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mycrypto/app/core/enums/use_biometric_permission_enum.dart';
import 'package:mycrypto/app/core/services/local_auth_service.dart';
import 'package:mycrypto/app/core/stores/use_biometric_store.dart';
import 'package:mycrypto/app/shared/widgets/button/button_primary_widget.dart';
import 'package:mycrypto/app/shared/widgets/button/button_secondary_widget.dart';

class PermissionBiometricPage extends StatefulWidget {
  const PermissionBiometricPage({Key? key}) : super(key: key);

  @override
  State<PermissionBiometricPage> createState() =>
      _PermissionBiometricPageState();
}

class _PermissionBiometricPageState extends State<PermissionBiometricPage> {
  final UseBiometricStore _store = Modular.get();
  BiometricType _biometricType = BiometricType.face;

  @override
  void initState() {
    getBiometricType();
    super.initState();
  }

  void getBiometricType() async {
    _biometricType = await LocalAuthService.getBiometricType();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _biometricType == BiometricType.face
              ? SvgPicture.asset(
                  'assets/login/face_id.svg',
                  height: MediaQuery.of(context).size.height * 0.15,
                  color: Theme.of(context).colorScheme.primary,
                )
              : Icon(
                  _biometricType == BiometricType.fingerprint
                      ? Icons.fingerprint
                      : _biometricType == BiometricType.iris
                          ? Icons.remove_red_eye
                          : Icons.security_rounded,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            Platform.isIOS
                ? 'Desbloquear com ${_biometricType == BiometricType.face ? 'Face ID' : 'Touch ID'}'
                : 'Desbloquear com ${_biometricType == BiometricType.face ? 'Reconhecimento Facial' : 'Digital'}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            'Para mais segurança, recomendamos que aceite o uso de biometria para desbloquear o aplicativo.',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ButtonPrimaryWidget(
            text: 'Aceitar',
            isLoading: false,
            onPressed: () async {
              // LocalAuthService.authenticate().then(
              //   (value) {
              //     _store.changeBiometricPermission(true);
              //     _store.updateState(UseBiometricPermissionEnum.accepted);
              //     Modular.to.pushReplacementNamed('/home/');
              //   },
              // );
              _store.setHasBiometrics(true);
              _store.updateState(UseBiometricPermissionEnum.accepted);
              Modular.to.pushReplacementNamed('/home/');
            },
          ),
          const SizedBox(height: 20),
          ButtonSecondaryWidget(
            text: 'Negar',
            isLoading: false,
            onPressed: () async {
              _store.setHasBiometrics(false);
              _store.updateState(UseBiometricPermissionEnum.denied);
              Modular.to.pushReplacementNamed('/home/');
            },
          ),
        ],
      ),
    );
  }
}
