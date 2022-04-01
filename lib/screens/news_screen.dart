import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/webview_widget.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/showcheck_widget.dart';
import '../helper/constant.dart';
import '../helper/helper.dart';

class NewScreen extends StatefulWidget {
    const NewScreen({ Key? key }) : super(key: key);

    @override
    State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
    String ulrRss = "https://thanhnien.vn/rss/thoi-su/dan-sinh-176.rss";
    bool isLoading = false;
    bool checkInternet = false;
    RssFeed rssData = RssFeed();
    late GlobalKey<RefreshIndicatorState> _refreshKey;

    loadData() async{
        try{
            setState(() {
                isLoading = true;
            });
            final res = await http.get(Uri.parse(ulrRss));
            var data = RssFeed.parse(res.body);
            setState(() {
                rssData = data;
                isLoading = false;
            });
        }catch(e){
            throw Exception(e);
        }
    }
    
    @override
    void initState() {
        // TODO: implement initState
        _refreshKey = GlobalKey<RefreshIndicatorState>();
        InternetConnectionChecker().onStatusChange.listen((status){
            final hasInternet = status == InternetConnectionStatus.connected;
            setState(() {
                checkInternet = hasInternet;
            });
            loadData();
        });
        super.initState();
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: appBar(context, "Tin tức trong nước"),
            body: checkInternet == false ? checkData("Không có kết nối Internet") :
                isLoading == false ?
                    Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: RefreshIndicator(
                            key: _refreshKey,
                            color: greenColor,
                            child: ListView.builder(
                                itemCount: rssData.items!.length,
                                itemBuilder: (context, int i){
                                    final item = rssData.items![i];
                                    var description = item.description.toString();
                                    var image;
                                    if (description.startsWith("<a ")) {            
                                        String getImg = description.substring(description.indexOf("src=") + 5, description.indexOf("align") - 2);
                                        image = getImg;
                                        
                                    }
                                    return GFListTile(
                                        margin: const EdgeInsets.all(0),
                                        avatar: GFAvatar(
                                            backgroundImage: NetworkImage(image),
                                            shape: GFAvatarShape.standard,
                                            size: 42,
                                        ),
                                        title: Text(
                                            item.title.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                height: 1.1,
                                            ),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        subTitle: Padding(
                                            padding: const EdgeInsets.only(top: 3.0),
                                            child: Row(
                                                children: <Widget>[
                                                    const Icon(Ionicons.time_outline, size: 13.0,),
                                                    const SizedBox(width: 2.0,),
                                                    Text(
                                                        formatDate(item.pubDate),
                                                        style: const TextStyle(
                                                            fontSize: 11.0
                                                        ),
                                                    )
                                                ],
                                            )
                                        ),
                                        onTap: () => linkRoute(context, item.title.toString(), item.link.toString()),
                                    );
                                }
                            ),
                            onRefresh: () => loadData(),
                        )
                    )
                :
                ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, i){
                        return GFListTile(
                            margin: const EdgeInsets.only(top: 10.0),
                            avatar: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                    width: 70,
                                    height: 60,
                                    color: whiteColor,
                                ),
                            ),
                            title: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                    width: double.infinity,
                                    height: 40,
                                    color: whiteColor,
                                ),
                            ),
                            subTitle: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    width: 100,
                                    height: 10,
                                    color: whiteColor,
                                ),
                            ),
                        );
                    },
                )
        );
    }
}
