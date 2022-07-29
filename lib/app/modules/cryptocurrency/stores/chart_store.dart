import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/charts_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/charts_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';

class ChartStore extends NotifierStore<DioError, ChartModel> {
  ChartStore() : super(ChartModel());
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
      final ChartsParamsModel chartsParamsModel = ChartsParamsModel();
      




  Future<void> getChartData() async {
    setLoading(true);
    await _repository.getChartData(chartsParamsModel).then((value) {
      update(value);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      setError(onError);
    });
  }
}
