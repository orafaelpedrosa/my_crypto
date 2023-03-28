import 'package:flutter_triple/flutter_triple.dart';

class HomeStore extends Store<int> {
  HomeStore() : super(0);

  Future<void> updateIndex(int index) async {
    update(index);
  }
}
