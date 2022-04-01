import 'package:covid_tracker/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../models/chart_model.dart';
SfCartesianChart ModelChartTimeLineCovid(dataSource, dataAvg, String name, color) {
    return SfCartesianChart(
        legend: Legend(
            isVisible: true, 
            position: LegendPosition.bottom
        ),
        margin: const EdgeInsets.all(0),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<ModelChartTimeLine, String>>[
            ColumnSeries<ModelChartTimeLine, String>(
                dataSource: dataSource,
                xValueMapper: (ModelChartTimeLine data, _) => data.date,
                yValueMapper: (ModelChartTimeLine data, _) => data.value,
                name: name,
                width: 0.4, 
                color: color
            ),
            LineSeries<ModelChartTimeLine, String>(
                dataSource: dataAvg,
                xValueMapper: (ModelChartTimeLine data, _) => data.date,
                yValueMapper: (ModelChartTimeLine data, _) => data.value,
                name: "Trung bình 7 ngày",
                enableTooltip: true,
                color: redColor
            ),
        ],
        primaryXAxis: CategoryAxis(
            labelRotation: 15,
            labelAlignment: LabelAlignment.end
        ),
        primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(),
            labelAlignment: LabelAlignment.start
        ),
    );
}   