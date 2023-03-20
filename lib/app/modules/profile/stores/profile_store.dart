import 'package:flutter_triple/flutter_triple.dart';

class ProfileStore extends NotifierStore<Exception, int> {
  ProfileStore() : super(0);

  Future<void> increment() async {
    setLoading(true);
    await Future.delayed(Duration(seconds: 1));
    update(state + 1);
    setLoading(false);
  }
}
