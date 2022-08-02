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
  ChartsParamsModel chartsParamsModel = ChartsParamsModel();
  ChartModel chart = ChartModel();

  Future<void> getChartData() async {
    final List<double> data = List<double>.empty(growable: true);
    setLoading(true);
    chart = await _repository.getChartData(chartsParamsModel);
    chart.prices!.forEach((element) {
      data.add(element.last.toDouble());
    });
    chart.pricesChart = data;
    update(chart);
    setLoading(false);
  }
}
