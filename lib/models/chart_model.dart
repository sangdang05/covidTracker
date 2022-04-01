import 'package:flutter/material.dart';
class ModelChartPieData{
    final dynamic title;
    final num? data;
    final Color? pointColor;
    final String? text;
    ModelChartPieData({
        this.title,
        this.data,
        this.pointColor,
        this.text,
    });
}
class ModelChartTimeLine{
    final String date;
    final int value;
    ModelChartTimeLine({required this.date, required this.value});
}
class ModelChartMap{
    final String country;
    final int countCase;
    final int countDeath;
    final int countToday;
    ModelChartMap(
        this.country,
        this.countDeath,
        {
            required this.countCase,
            required this.countToday,
        }    
    );
}