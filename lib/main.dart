import 'package:flutter/material.dart';
import './helper/constant.dart';
import './app_screen.dart';
void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Open Sans',
                brightness: Brightness.light,
                textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: blueColor,
                ),
            ),
            home: const AppScreen(),
        );
    }
}