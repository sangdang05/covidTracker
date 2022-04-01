import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../widgets/webview_widget.dart';
formatCase(int value){
    String a =  NumberFormat.decimalPattern().format(value).replaceAll(",", ".");
    return a;
}
formatDate(var value){
    var date = DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.parse(value.toString()));
    return date;
}
formatNumber(double value){
    double a = double.parse(value.toStringAsFixed(2));
    return a;
}
lauchUrl(String url) async{
    if(await canLaunch(url)){
        launch(
            url,
            enableJavaScript: true,
        );
    }
    else{
        throw Exception("Không thể tải liên kết");
    }
}
linkRoute(BuildContext context, String title, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(title, url)));
}
