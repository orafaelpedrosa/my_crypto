import 'dart:developer';

import 'package:flutter_triple/flutter_triple.dart';

class ObscureStore extends NotifierStore<Exception, bool> {
  ObscureStore() : super(true);
}
