import 'package:flutter/material.dart';
import '../helper/constant.dart';
Column symptomBlock(BuildContext context , {title, image}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Card(          
                shadowColor: greenColor,   
                elevation: 2.0,        
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                        children: [
                            Container(
                                width: 95,
                                height: 95,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(image),
                                        fit: BoxFit.contain,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                ),
                            ),
                              const SizedBox(height: paddingDefault/2),
                             Text(
                                title, 
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center,
                            )
                        ],
                    ),
                ),
            ),
        ],
    );
}