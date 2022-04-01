import 'package:flutter/material.dart';
import '../helper/constant.dart';
Flexible boxStatis(title, color, String dataCase, String today) {
    return Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Container(
            height: 112,
            padding: const EdgeInsets.only(top: 10.0, left: 12.0, bottom: 10.0, right: 12.0),
            margin: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color.withOpacity(0.1),
                border: Border.all(width: 1.0, color: color.withOpacity(0.3))
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            title, 
                            style: TextStyle(
                                color: color,
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                            )
                        ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                                Text(
                                    dataCase,
                                    style: TextStyle(
                                        color: color,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700
                                    ),
                                ),
                                const SizedBox(height: 2.0,),
                                today != "0" ?
                                Text(
                                    "+ " + today,
                                    style: TextStyle(
                                        color: color,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600
                                    ),
                                ):
                                Align()
                            ],
                        )
                    )
                ],
            ), 
        ), 
    );
}