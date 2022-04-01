import 'dart:io';
import 'package:covid_tracker/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/showcheck_widget.dart';
class WebViewContainer extends StatefulWidget {
    final url;
    final title;
    WebViewContainer(this.title, this.url);
    @override
    createState() => _WebViewContainerState(this.title, this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
    var _url;
    String _title;
    final _key = UniqueKey();
    _WebViewContainerState(this._title, this._url);
    bool isLoading = true;
    @override
    void initState() {
        // TODO: implement initState
        if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
        super.initState();
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: whiteColor,
                title: Text(
                    _title,
                    style: const TextStyle(
                        color: blackColor,
                        fontSize: 14.0
                    ),
                ),
                iconTheme: const IconThemeData(
                    color: Colors.grey
                ),
                centerTitle: true,
            ),
            body: Stack(
                children: <Widget>[
                    WebView(
                        key: _key,
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: _url,
                        onPageFinished: (finish){
                            setState(() {
                                isLoading = false;
                            });
                        },
                    ),
                    isLoading ? Center(
                        child: checkData(""),
                    ): Stack()
                ],
            )
        );
    }
}
