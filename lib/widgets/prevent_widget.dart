import 'package:flutter/material.dart';
import '../helper/constant.dart';
Card preventBlock(BuildContext context, {title, descriptions, image}) {
    return Card(
        shadowColor: greenColor,   
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 3.0, 5.0),
            child: Row(
                children: <Widget>[
                    Image.asset(image, width: 95, fit: BoxFit.cover,),
                    const SizedBox(width: paddingDefault/1.5),
                    Flexible(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Text(
                                    title,
                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                        fontWeight: FontWeight.w700
                                    )
                                ),
                                const SizedBox(height: paddingDefault/3,),
                                Text(
                                    descriptions,
                                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                                        fontWeight: FontWeight.normal
                                    )
                                )
                            ],
                        ),
                    )
                ],
            ),
        ),
    );
}