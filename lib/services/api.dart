import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/statistic_model.dart';
import '../models/timeline_model.dart';
import '../models/province_model.dart';

String UrlApi = "https://static.pipezero.com/covid/data.json";

Future<ModelStatsticGeneral> getDataGeneral() async{
    try{
        final res = await http.get(Uri.parse(UrlApi));
        if(res.statusCode == 200){
            print(res.statusCode);
            return modelStatsticGeneralFromJson(res.body);
        }
        else{
            throw Exception("Có lỗi khi lấy dữ liệu");
        }
    }catch(e){
        rethrow;
    }
}
Future<ModelTimeline> getDataTimeLine() async{
    try{
        final res = await http.post(
            Uri.parse(UrlApi),
        );
        if(res.statusCode == 200){
            return ModelTimelineFromJson(res.body);
        }
        else{
            throw Exception("Có lỗi khi lấy dữ liệu theo ngày");
        }
    }catch(e){
        rethrow;
    }
}
Future<ModelDataProvince> getDataProvince() async{
    try{
        final res = await http.get(Uri.parse(UrlApi));
        if(res.statusCode == 200){
            return modelDataProvinceFromJson(res.body);
        }
        else{
            throw Exception("Có lỗi khi lấy dữ liệu các tỉnh");
        }
    }catch(e){
        rethrow;
    }

}
