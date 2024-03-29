import 'package:translator/translator.dart';

class TranslatorService {
  static Future<String> translate(String stringToTranslate) async {
    final translator = GoogleTranslator();
    Translation? translated;
    await translator.translate(stringToTranslate, from: 'en', to: 'pt').then(
      (translate) {
        translated = translate;
      },
    );
    return translated!.text;
  }
}