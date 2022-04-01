import 'package:flutter/material.dart';
import '../helper/constant.dart';
PreferredSize appBar(BuildContext context, text) {
     return PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
            title: Text(
                text,
                style: Theme.of(context).textTheme.subtitle1
            ),
            centerTitle: true,
            backgroundColor: whiteColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                ),
            ),
            shadowColor: blueColor,
        ),
    );
}