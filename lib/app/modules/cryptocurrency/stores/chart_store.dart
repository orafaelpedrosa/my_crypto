import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';

class ChartStore extends NotifierStore<DioError, List<double>> {
  ChartStore() : super([]);
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  ChartsParamsModel chartsParamsModel = ChartsParamsModel();
  ChartModel chartModel = ChartModel();

  // Future<void> getChartData() async {
  //   setLoading(true);
  //   await _repository.getChartData(chartsParamsModel).then((value) {
  //     // update(value);
  //     setLoading(false);
  //   }).catchError((onError) {
  //     setLoading(false);
  //     log(onError.toString());
  //     setError(onError);
  //   });
  // }

  Future<void> getChartData() async {
    final List<double> data = [];
    setLoading(true);
    log('getChartData ${chartsParamsModel.days}');
    chartModel = await _repository.getChartData(chartsParamsModel);
    chartModel.prices!.forEach((element) {
      data.add(element.last.toDouble());
    });
    update(data);
    setLoading(false);
  }
}
