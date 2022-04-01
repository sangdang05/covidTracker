import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../helper/constant.dart';
Center checkData(text) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                CircularProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    color: greenColor,
                    strokeWidth: 3,
                ),
                const SizedBox(height: 10.0,),
                Shimmer.fromColors(
                    baseColor: Colors.green,
                    highlightColor: Colors.green.shade100,
                    child: Text(
                        text,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600
                        ),
                    ),
                ),
            ],
        ),
    );
}