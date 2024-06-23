import 'package:control_stock_web_admin/core/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final dynamic x;
  final double y;

  ChartData(this.x, this.y);
}

class HistoricalProductVariationsLineChart extends StatefulWidget {
  final String title;
  final List<ChartData> values;
  final Color? color;
  const HistoricalProductVariationsLineChart({super.key, required this.title, required this.values, this.color});

  @override
  State<HistoricalProductVariationsLineChart> createState() => _HistoricalProductVariationsLineChartState();
}

class _HistoricalProductVariationsLineChartState extends State<HistoricalProductVariationsLineChart> {
  late List<FlSpot> spots;
  late List<ChartData> data;

  @override
  void initState() {
    super.initState();

    data = widget.values.map((e) => ChartData(e.x.toString(), e.y)).toList();
    data.sort((a, b) => a.x.compareTo(b.x));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          title: ChartTitle(text: widget.title),
          legend: const Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CartesianSeries<ChartData, String>>[
            LineSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData chartData, _) => chartData.x,
              yValueMapper: (ChartData chartData, _) => chartData.y,
              legendItemText: '',
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              color: widget.color ?? colorScheme.primary,
            )
          ]),
    ]);
  }
}
