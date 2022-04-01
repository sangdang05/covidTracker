import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../models/province_model.dart';
import '../services/api.dart';
import '../helper/constant.dart';
import '../helper/helper.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/showcheck_widget.dart';

class ProvinceScreen extends StatefulWidget {
    const ProvinceScreen({ Key? key }) : super(key: key);

    @override
    State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
    List<modelFilter> _listData = [];
    List<modelFilter> _userFilter = [];
    String userSearch = "";
    TextEditingController _searchController = TextEditingController();
    bool _isLoading = true;
    bool _checkInternet = false;
    Future<void> getData() async{
        final res = await http.get(Uri.parse("https://static.pipezero.com/covid/data.json"));
        if(res.statusCode == 200){
            var data = modelDataProvinceFromJson(res.body);
            for(var i in data.locations){
                setState(() {
                    _listData.add(modelFilter(i.name, i.cases, i.casesToday, i.death));
                });
            }
        }
    }
    @override
    void initState() {
        // TODO: implement initState
        InternetConnectionChecker().onStatusChange.listen((status){
            final hasInternet = status == InternetConnectionStatus.connected;
            setState(() {
                _checkInternet = hasInternet;
            });
        });
        getData().then((value) => {
            _isLoading = false,
            _userFilter = _listData
        });
        //FocusScope.of(context).unfocus();
        super.initState();
    }
    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: appBar(context, "Tình hình dịch cả nước"),
                body: _checkInternet == true ? Column(
                    children: [
                        // ignore: avoid_unnecessary_containers
                        Container(
                            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.0, color: greenColorLight),
                                borderRadius: const BorderRadius.all(Radius.circular(15))
                            ),
                            child: ListTile(
                                leading: const Icon(Icons.search),
                                title: TextField(
                                    controller: _searchController,
                                    style: Theme.of(context).textTheme.subtitle2,
                                    decoration: const InputDecoration(
                                        hintText: 'Tìm kiếm theo tỉnh/TP', 
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 14.0
                                        ),
                                    ),
                                    onChanged: (value) {
                                        setState(() {
                                            userSearch = value;
                                            _userFilter = _listData.where((user) => user.name.toLowerCase().contains(userSearch)).toList();
                                        });
                                    }
                                ),
                                trailing: IconButton(
                                    icon: const Icon(Ionicons.close),
                                    onPressed: (){
                                        setState(() {
                                            _searchController.clear();
                                            userSearch = "";
                                            _userFilter = _listData;
                                        });
                                        FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                ),
                            ),
                        ),
                        Expanded(
                            child: _checkInternet == true && _isLoading == false?
                                ListView.builder(
                                    itemCount: _userFilter.length,
                                    itemBuilder: (context, i){
                                        return Card(
                                            child: ListTile(
                                                title: Text(
                                                    _userFilter[i].name,
                                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                        fontWeight: FontWeight.w700
                                                    )
                                                ),
                                                subtitle: Row(
                                                    children: <Widget>[
                                                        Padding(
                                                            padding: const EdgeInsets.only(top: 5.0),
                                                            child: Row(
                                                                children: <Widget>[
                                                                    Text(
                                                                        "Số ca: ", 
                                                                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                                                            fontWeight: FontWeight.normal
                                                                        )
                                                                    ),
                                                                    Text(
                                                                        formatCase(_userFilter[i].cases),
                                                                        style: const TextStyle(
                                                                            fontSize: 14.0,
                                                                            fontWeight: FontWeight.w700,
                                                                            color: greenColorLight
                                                                        ),
                                                                    )
                                                                ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 4.0,),
                                                        Container(
                                                            width: 1,
                                                            height: 18,
                                                            color: Colors.grey.shade400,
                                                        ),
                                                        const SizedBox(width: 4.0,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 5.0),
                                                            child: Row(
                                                                children: <Widget>[
                                                                    Text(
                                                                        "Tử vong: ", 
                                                                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                                                            fontWeight: FontWeight.normal
                                                                        ) 
                                                                    ),
                                                                    Text(
                                                                        formatCase(_userFilter[i].death),
                                                                        style: const TextStyle(
                                                                            fontSize: 14.0,
                                                                            fontWeight: FontWeight.w600,
                                                                            color: Colors.black54
                                                                        ),
                                                                    )
                                                                ],
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                                trailing: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                        Text(
                                                            "24h qua",
                                                            style: Theme.of(context).textTheme.caption
                                                        ),
                                                        const SizedBox(height: 2.0,),
                                                        Text(
                                                            "+" + formatCase(_userFilter[i].casesToday),
                                                            style: const TextStyle(color: redColor, fontWeight: FontWeight.w600),
                                                        ),
                                                    ],
                                                )
                                            ),
                                        );
                                    },
                                )
                            : checkData("Đang tải dữ liệu...")
                        ), 
                    ],
                ): checkData("Không có kết nối Internet")
            ),
        );  
    }   
}   
class modelFilter{
    String name;
    int death;
    int cases;
    int casesToday;
    modelFilter(
        this.name,
        this.cases,
        this.casesToday, 
        this.death, 
    );
}
