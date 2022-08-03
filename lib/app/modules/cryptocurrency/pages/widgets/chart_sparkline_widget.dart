import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/models/chart_model/charts_model.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/chart_store.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartSparklineWidget extends StatefulWidget {
  final double? priceChangePercentage;
  const ChartSparklineWidget({
    Key? key,
    this.priceChangePercentage,
  }) : super(key: key);

  @override
  State<ChartSparklineWidget> createState() => _ChartSparklineWidgetState();
}

class _ChartSparklineWidgetState extends State<ChartSparklineWidget> {
  final ChartStore _store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ChartStore, Exception, ChartModel>(
      store: _store,
      builder: (_, triple) {
        return SfSparkLineChart(
          color: widget.priceChangePercentage != null
              ? (widget.priceChangePercentage! > 0)
                  ? Colors.green
                  : Colors.red
              : Colors.blue,
          highPointColor: Colors.blue,
          axisLineColor: Colors.transparent,
          data: _store.state.pricesChart,
          marker: SparkChartMarker(
            color: Colors.blue,
          ),
        );
      },
    );
  }
}
