import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import './helper/constant.dart';
import './screens/home_screen.dart';
import './screens/statistic_screen.dart';
import './screens/map_screen.dart';
import './screens/province_screen.dart';
import './screens/news_screen.dart';
class AppScreen extends StatefulWidget {
    const AppScreen({ Key? key }) : super(key: key);
    @override
    _AppScreenState createState() => _AppScreenState();
}
class _AppScreenState extends State<AppScreen> {
    int _pageIndex = 0;
    List<Widget> page = [
        const HomePage(),
        const StatisticScreen(),
        const ProvinceScreen(),
        const MapScreen(),
        const NewScreen()
    ];
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: IndexedStack(
                //controller: _pageController,
                //children: page, 
                children: page,
                index: _pageIndex,
            ),
            bottomNavigationBar: GNav(
                gap: 5,
                tabBackgroundColor: blueColor.withOpacity(0.1),
                activeColor: greenColorLight, 
                iconSize: 23,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                tabs: [
                    tabIcon(Ionicons.home_outline, "Trang chủ"),
                    tabIcon(Ionicons.podium_outline, "Thống kê"),
                    tabIcon(Ionicons.reader_outline, "Số liệu"),
                    tabIcon(Ionicons.map_outline, "Bản đồ"),
                    tabIcon(Ionicons.newspaper_outline, "Tin tức"),
                ],
                onTabChange: _onTappedBar,
            )
        );
    }
    void _onTappedBar(int value) {
        setState(() {
          _pageIndex = value;
        });
       // _pageController.jumpToPage(value);
    }
    GButton tabIcon(icon, text) {
        return GButton(
            icon: icon,
            text: text,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(5, 9, 5, 9)
        );
    }
}