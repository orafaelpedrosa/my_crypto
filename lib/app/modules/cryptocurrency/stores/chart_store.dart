import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_params_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/repositories/cryptocurrency_repository.dart';

// ignore: must_be_immutable
class ChartStore extends NotifierStore<DioError, ChartModel> {
  ChartStore() : super(ChartModel());
  final CryptocurrencyRepository _repository =
      Modular.get<CryptocurrencyRepository>();
  ChartsParamsModel paramsChart = ChartsParamsModel();
  ChartModel chart = ChartModel();

  Future<void> getChartData() async {
    final List<double> data = List<double>.empty(growable: true);
    setLoading(true);
    log('getChart ${paramsChart.days}');

    chart = await _repository.getChartData(paramsChart);
    chart.prices!.forEach((element) {
      data.add(element.last.toDouble());
    });
    chart.pricesChart = data;
    update(chart);
    setLoading(false);
  }

  void changeChart(int period) {
    log('changeChart $period');

    switch (period) {
      case 0:
        paramsChart.days = '1d';
        break;
      case 1:
        paramsChart.days = '7d';
        break;
      case 2:
        paramsChart.days = '30d';
        break;
      case 3:
        paramsChart.days = '365d';
        break;
      default:
        paramsChart.days = '1d';
        break;
    }
    getChartData();
  }



  Future<void> updateState() async {
    update(state);
  }
}
