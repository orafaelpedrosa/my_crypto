import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/core/stores/user_store.dart';
import 'package:mycrypto/app/modules/wallet/models/transaction_model.dart';

// ignore: must_be_immutable
class TransactionHistoryStore extends Store<List<TransactionHistoryModel>> {
  TransactionHistoryStore() : super([]);

  UserStore userStore = Modular.get();

  Future<void> getAllHistoricByWallet() async {
    setLoading(true);

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userStore.user!.uid)
          .collection('transactions')
          .get();

      List<TransactionHistoryModel> list = snapshot.docs
          .map((doc) => TransactionHistoryModel.fromMap(
              doc.data() as Map<String, dynamic>))
          .toList();

      list.sort((a, b) => b.date!.compareTo(a.date!));

      update(list, force: true);
    } catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<void> getHistoricByDate(DateTime dateFilter) async {
    setLoading(true);
    List<TransactionHistoryModel> list = [];

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userStore.user!.uid)
          .collection('transactions')
          .get();

      if (snapshot.docs.isNotEmpty) {
        list = snapshot.docs
            .map((doc) => TransactionHistoryModel.fromMap(
                doc.data() as Map<String, dynamic>))
            .where((element) =>
                element.date!.day == dateFilter.day &&
                element.date!.month == dateFilter.month &&
                element.date!.year == dateFilter.year)
            .toList();

        list.sort((a, b) => b.date!.compareTo(a.date!));
      }

      update(list, force: true);
    } catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<void> getHistoricByID(String id) async {
    setLoading(true);
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userStore.user!.uid)
          .collection('transactions')
          .where('id', isEqualTo: id)
          .get();

      List<TransactionHistoryModel> list = snapshot.docs
          .map((doc) => TransactionHistoryModel.fromMap(
              doc.data() as Map<String, dynamic>))
          .toList();

      list.sort((a, b) => b.date!.compareTo(a.date!));

      update(list, force: true);
    } catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<void> clear() async {
    setLoading(true);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userStore.user!.uid)
          .collection('transactions')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      update(List.empty(growable: true), force: true);
    } catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
