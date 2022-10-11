import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FirestoreRepository with Disposable {
  FirestoreRepository._();

  static final FirestoreRepository _instance = FirestoreRepository._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseFirestore get() {
    return FirestoreRepository._instance._firestore;
  }

  @override
  void dispose() {}
}
