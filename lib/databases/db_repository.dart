import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DBRepository with Disposable {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static FirebaseFirestore get() {
    return _db;
  }

  @override
  void dispose() {}
}