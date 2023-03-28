import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/authentication/register/register_repository.dart';

class AccetpTermsStore extends Store<bool> {
  AccetpTermsStore() : super(false);

  final RegisterRepository _registerRepository =
      Modular.get<RegisterRepository>();

  Future<void> acceptTerms(bool value) async {
    setLoading(true);
    update(value);
    setLoading(false);
  }

  Future<void> setAcceptTerms(bool value) async {
    setLoading(true);
    await _registerRepository.setAcceptTerms(value).then((element) {
      update(value);
      setLoading(false);
    }).catchError((error) {
      setLoading(false);
      throw error;
    });
  }
}
