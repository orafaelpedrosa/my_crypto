import 'package:flutter_test/flutter_test.dart';
import 'package:mycrypto/app/modules/crypto/cryptocurrency_store.dart';
 
void main() {
  late CryptocurrencyStore store;

  setUpAll(() {
    store = CryptocurrencyStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}