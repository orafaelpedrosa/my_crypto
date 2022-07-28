import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartSparkline7dWidget extends StatefulWidget {
  final List<double> data;
  final double? priceChangePercentage7d;
  const ChartSparkline7dWidget({
    Key? key,
    required this.data,
    this.priceChangePercentage7d,
  }) : super(key: key);

  @override
  State<ChartSparkline7dWidget> createState() => _ChartSparkline7dWidgetState();
}

class _ChartSparkline7dWidgetState extends State<ChartSparkline7dWidget> {
  @override
  Widget build(BuildContext context) {
    return SfSparkLineChart(
      color: widget.priceChangePercentage7d != null
          ? (widget.priceChangePercentage7d! > 0)
              ? Colors.green
              : Colors.red
          : Colors.blue,
          
      highPointColor: Colors.blue,
      axisLineColor: Colors.transparent,
      data: widget.data,
      marker: SparkChartMarker(
        color: Colors.blue,
      ),
    );
  }
}
