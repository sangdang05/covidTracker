import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/statistic_model.dart';
import '../models/chart_model.dart';
import '../models/timeline_model.dart';
import '../services/api.dart';
import '../helper/constant.dart';
import '../helper/helper.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/boxstatis_widget.dart';
import '../widgets/showcheck_widget.dart';
import '../widgets/charttime_widget.dart';

class StatisticScreen extends StatefulWidget {
    const StatisticScreen({ Key? key }) : super(key: key);

    @override
    State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
    late Future<ModelStatsticGeneral> _statis;
    late Future<ModelTimeline> _timeline;
    late int cases, recovered, deaths, active;
    late int todayCase, todayRecovered, todayDeath, todayActive;
    late double total, percentRecovered, percentActive, percentDeath;
    List<ModelChartTimeLine> dataCase = [], dataDeath = [], dataRecovered = []; 
    List<ModelChartTimeLine> dataAvgCase = [], dataAvgDeath = [], dataAvgRecovered = []; 
    List<String> date = [];
    List<int> valueCase = [], valueDeath = [], valueRecovered = [];
    List<int> valueAvgCase = [], valueAvgDeath = [], valueAvgRecovered = [];
    bool checkInternet = false;
    bool _isLoading = true;
    @override
    void initState() {
      // TODO: implement initState
        InternetConnectionChecker().onStatusChange.listen((status){
            final hasInternet = status == InternetConnectionStatus.connected;
            setState(() {
                checkInternet = hasInternet;
            });
            _statis = getDataGeneral();
            _timeline = getDataTimeLine();
        });
      super.initState();
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: appBar(context, "Thống kê Covid-19 trong nước"),
            body: Center(
                child: SingleChildScrollView(
                    child: checkInternet == false ? checkData("Không có kết nối Internet") : 
                    FutureBuilder<ModelStatsticGeneral>(
                        future: _statis,
                        builder: (context, snapshot){
                            if(snapshot.hasData){
                                total = snapshot.data!.total.internal.cases.toDouble();
                                cases = snapshot.data!.total.internal.cases;
                                recovered = snapshot.data!.total.internal.recovered;
                                deaths = snapshot.data!.total.internal.death;
                                active = snapshot.data!.total.internal.active;
                                todayCase = snapshot.data!.today.internal.cases;
                                todayRecovered = snapshot.data!.today.internal.recovered;
                                todayDeath = snapshot.data!.today.internal.death;
                                todayActive = todayCase - (todayRecovered + todayDeath);
                                percentRecovered = formatNumber((recovered/total*100));
                                percentActive = formatNumber((active/total*100));
                                percentDeath = formatNumber((deaths/total*100));
                                return Column(
                                    children: [
                                        const SizedBox(height: paddingDefault,),
                                        Row(
                                            children: <Widget>[
                                                boxStatis("Tổng số ca", redColor, formatCase(cases), formatCase(todayCase)),
                                                boxStatis("Điều trị", blueColor, formatCase(active), formatCase(0))
                                            ],
                                        ),
                                        Row(
                                            children: <Widget>[
                                                boxStatis("Hồi phục", greenColorLight, formatCase(recovered), formatCase(todayRecovered)),
                                                boxStatis("Tử vong", greyColor, formatCase(deaths), formatCase(todayDeath)),
                                            ],
                                        ),
                                        const Center(
                                            child: Text(
                                                "(+) Dữ liệu trong 24h qua",
                                                style: TextStyle(
                                                    fontSize: 12.0
                                                )
                                            ),    
                                        ),
                                        const SizedBox(height: paddingDefault/2,),
                                        SfCircularChart(
                                            margin: const EdgeInsets.all(0),
                                            legend: Legend(isVisible: true),
                                            series: <DoughnutSeries<ModelChartPieData, String>>[
                                                DoughnutSeries<ModelChartPieData, String>(
                                                    explode: true,
                                                    explodeIndex: 0,
                                                    explodeOffset: '10%',
                                                    dataSource: <ModelChartPieData>[
                                                        ModelChartPieData(title: 'Hồi phục', data: percentRecovered, text: '$percentRecovered%', pointColor: greenColorLight),
                                                        ModelChartPieData(title: 'Đang điều trị', data: percentActive, text: '$percentActive%', pointColor: blueColor),
                                                        ModelChartPieData(title: 'Tử vong', data: percentDeath, text: '$percentDeath%', pointColor: redColor),
                                                    ],
                                                    xValueMapper: (ModelChartPieData data, _) => data.title,
                                                    yValueMapper: (ModelChartPieData data, _) => data.data,
                                                    dataLabelMapper: (ModelChartPieData data, _) => data.text,
                                                    pointColorMapper: (ModelChartPieData data, _) => data.pointColor,
                                                    dataLabelSettings: const DataLabelSettings(isVisible: true,), 
                                                    radius: '90%'
                                                )
                                            ],
                                        ),
                                        FutureBuilder<ModelTimeline>(
                                            future: _timeline,
                                            builder: (context, snapshot){
                                                if(snapshot.hasData){
                                                    // ignore: avoid_function_literals_in_foreach_calls
                                                    snapshot.data!.overview.forEach((e) => {
                                                        date.add(e.date),
                                                        valueCase.add(e.cases),
                                                        valueRecovered.add(e.recovered),
                                                        valueDeath.add(e.death),
                                                        valueAvgCase.add(e.avgCases7Day),
                                                        valueAvgRecovered.add(e.avgRecovered7Day),
                                                        valueAvgDeath.add(e.avgDeath7Day),
                                                    });
                                                    for(var i = 0; i < date.length; i++){
                                                        dataCase.add(ModelChartTimeLine(date: date[i], value: valueCase[i]));
                                                        dataDeath.add(ModelChartTimeLine(date: date[i], value: valueDeath[i]));
                                                        dataRecovered.add(ModelChartTimeLine(date: date[i], value: valueRecovered[i]));
                                                        dataAvgCase.add(ModelChartTimeLine(date: date[i], value: valueAvgCase[i]));
                                                        dataAvgRecovered.add(ModelChartTimeLine(date: date[i], value: valueAvgRecovered[i]));
                                                        dataAvgDeath.add(ModelChartTimeLine(date: date[i], value: valueAvgDeath[i]));
                                                    }
                                                    return Container(
                                                        width: double.infinity,
                                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                                        decoration: const BoxDecoration(
                                                            color: whiteColor,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(20),
                                                                topRight: Radius.circular(20),
                                                            )
                                                        ),
                                                        child: Column(
                                                            children: <Widget>[
                                                                Padding(
                                                                    padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                                                                    child:  Center(
                                                                        child: Text("Biểu đồ ca nhiễm trong 7 ngày qua",
                                                                            style: Theme.of(context).textTheme.caption,
                                                                        )
                                                                    ),
                                                                ),
                                                                ModelChartTimeLineCovid(dataCase, dataAvgCase, "Ca nhiễm", blueColor),
                                                                const SizedBox(height: 15.0,),
                                                                Text("Biểu đồ ca hồi phục trong 7 ngày qua",
                                                                    style: Theme.of(context).textTheme.caption,
                                                                ),
                                                                const SizedBox(height: 10.0,),
                                                                ModelChartTimeLineCovid(dataRecovered, dataAvgRecovered, "Hồi phục", greenColorLight),
                                                                const SizedBox(height: 15.0,),
                                                                Text("Biểu đồ ca tử vong trong 7 ngày qua",
                                                                    style: Theme.of(context).textTheme.caption,
                                                                ),
                                                                const SizedBox(height: 10.0,),
                                                                ModelChartTimeLineCovid(dataDeath, dataAvgDeath, "Tử vong", Colors.grey),
                                                            ],
                                                        ),
                                                    );
                                                }
                                                return const Center(child: CircularProgressIndicator(),);
                                            },
                                        )
                                    ],
                                );
                            }
                            return checkData("Đang tải dữ liệu");
                        },
                    )
                ),
            ),
        );
    }
}