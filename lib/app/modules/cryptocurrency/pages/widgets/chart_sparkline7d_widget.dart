import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mycrypto/app/modules/cryptocurrency/stores/chart_store.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartSparkline7dWidget extends StatefulWidget {
  // final List<double> data;
  final double? priceChangePercentage7d;
  const ChartSparkline7dWidget({
    Key? key,
    // required this.data,
    this.priceChangePercentage7d,
  }) : super(key: key);

  @override
  State<ChartSparkline7dWidget> createState() => _ChartSparkline7dWidgetState();
}

class _ChartSparkline7dWidgetState extends State<ChartSparkline7dWidget> {
  final ChartStore chartStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ChartStore, Exception, List<double>>(
      store: chartStore,
      builder: (_, triple) {
        return SfSparkLineChart(
          color: widget.priceChangePercentage7d != null
              ? (widget.priceChangePercentage7d! > 0)
                  ? Colors.green
                  : Colors.red
              : Colors.blue,
          highPointColor: Colors.blue,
          axisLineColor: Colors.transparent,
          data: chartStore.state,
          marker: SparkChartMarker(
            color: Colors.blue,
          ),
        );
      },
    );
  }
}
