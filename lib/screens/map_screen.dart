import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../models/chart_model.dart';
import '../models/province_model.dart';
import '../services/api.dart';
import '../helper/constant.dart';
import '../helper/helper.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/showcheck_widget.dart';

class MapScreen extends StatefulWidget {
    const MapScreen({ Key? key }) : super(key: key);

    @override
    State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
    late List<ModelChartMap> dataMap = [];
    late Future<ModelDataProvince> _map;
    bool checkInternet = false;
    @override
    void initState() {
        // TODO: implement initState
        InternetConnectionChecker().onStatusChange.listen((status){
            final hasInternet = status == InternetConnectionStatus.connected;
            setState(() {
                checkInternet = hasInternet;
            });
        });
        _map = getDataProvince();
        super.initState();
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: appBar(context, "Bản đồ Tỉnh/TP theo số ca nhiễm"),
            body: Padding(
                padding: EdgeInsets.all(paddingDefault/2),
                child: Center(
                    child: checkInternet == false ? checkData("Không có kết nối Internet") :
                    FutureBuilder<ModelDataProvince>(
                        future: _map,
                        builder: (context, snapshot){
                            if(snapshot.hasData){
                                // ignore: avoid_function_literals_in_foreach_calls
                                snapshot.data!.locations.forEach((e) =>{
                                    dataMap.add(ModelChartMap(e.name, e.death, countCase: e.cases, countToday: e.casesToday)),
                                });
                                return SfMaps(
                                    layers: <MapLayer>[
                                        MapShapeLayer(
                                            source: MapShapeSource.asset(
                                                'assets/vietnam.json',
                                                shapeDataField: 'NAME_1',
                                                dataCount: dataMap.length,
                                                primaryValueMapper: (int index) => dataMap[index].country,
                                                shapeColorValueMapper: (int index) => dataMap[index].countCase,
                                                shapeColorMappers: <MapColorMapper>[
                                                    const MapColorMapper(
                                                        from: 0,
                                                        to: 9999,
                                                        color: Color.fromRGBO(255, 196, 170, 0.7),
                                                        text: '{1},{10.000}',
                                                    ),
                                                    const MapColorMapper(
                                                        from: 10000,
                                                        to: 49999,
                                                        color: Color.fromRGBO(255, 138, 142, 1),
                                                        text: '50.000',
                                                    ),
                                                    const MapColorMapper(
                                                        from: 50000,
                                                        to: 99999,
                                                        color: Color.fromRGBO(255, 57, 43, 1),
                                                        text: '100.000'
                                                    ),
                                                    const MapColorMapper(
                                                        from: 100000,
                                                        to: 499999,
                                                        color: Color.fromRGBO(183,21,37, 0.9),
                                                        text: '500.000'
                                                    ),
                                                    const MapColorMapper(
                                                        from: 500000,
                                                        to: 2000000000,
                                                        color: Color.fromRGBO(122, 8, 38, 1),
                                                        text: '500.000+'
                                                    ),
                                                ],
                                            ),
                                            strokeColor: Colors.white60,
                                            strokeWidth: 1.2,
                                            legend: const MapLegend.bar(
                                                MapElement.shape,
                                                position: MapLegendPosition.right,
                                                spacing: 1.1,
                                                segmentSize: Size(50.0, 7.0),
                                                textStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight: FontWeight.w600
                                                )
                                            ),
                                            shapeTooltipBuilder: (context, int index){
                                                return Padding(
                                                    padding: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
                                                    child: Text(
                                                        dataMap[index].country + "\n" +
                                                        "Số ca: " + formatCase(dataMap[index].countCase) + "\n" + 
                                                        "Tử vong: " + formatCase(dataMap[index].countDeath) + "\n" +
                                                        "24h qua: " + formatCase(dataMap[index].countToday),
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w700
                                                        ),
                                                    ),
                                                );
                                            },
                                            tooltipSettings: const MapTooltipSettings(
                                                color: whiteColor
                                            ),
                                            loadingBuilder: (BuildContext context){
                                                return Center(
                                                    child: CircularProgressIndicator(
                                                        backgroundColor: Colors.grey.shade300,
                                                        color: greenColor,
                                                        strokeWidth: 3,
                                                    ),
                                                );
                                            },
                                        ),
                                    ]
                                );
                            }
                            return checkData("Đang tải dữ liệu...");
                        },
                    )
                ),
            ),
        );
    }
}