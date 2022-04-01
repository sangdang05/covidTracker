import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../data/listPrevent.dart';
import '../data/listSymptom.dart';
import '../widgets/prevent_widget.dart';
import '../widgets/symptom_widget.dart';
import '../helper/constant.dart';
import '../helper/helper.dart';

class HomePage extends StatelessWidget {
    const HomePage({ Key? key }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    color: greenColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.elliptical(75, 15),
                                        bottomRight: Radius.elliptical(75, 15),
                                    )
                                ),
                                child: Stack(
                                    children: [
                                        Padding(
                                            padding: const EdgeInsets.only(top: 20.0, right: 10.0, bottom: 30.0, left: 10.0),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Text(
                                                        titleMain,
                                                        style: Theme.of(context).textTheme.headline6?.copyWith(
                                                            color: whiteColor,
                                                            fontWeight: FontWeight.w700
                                                        ),
                                                        textAlign: TextAlign.start,
                                                    ),
                                                    const SizedBox(height: 12.0),
                                                    Text(
                                                        content,
                                                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                            color: whiteColor,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16
                                                        )
                                                    ),
                                                    const SizedBox(height: paddingDefault+5),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                            ElevatedButton.icon(
                                                                icon: const Icon(Ionicons.call_outline),
                                                                label: const Text("Gọi ngay"),
                                                                onPressed: (){
                                                                    lauchUrl(tel);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    padding: paddingButton,
                                                                    shape: const StadiumBorder(),
                                                                    primary: const Color(0xFF4CD97B),
                                                                    onPrimary: whiteColor,
                                                                    textStyle: Theme.of(context).textTheme.subtitle1
                                                                )
                                                            ),
                                                            const SizedBox(width: 20.0,),
                                                            ElevatedButton.icon(
                                                                icon: Image.asset("assets/icons/zalo.png",
                                                                    width: 23,
                                                                    height: 23,
                                                                ),
                                                                label: const Text("Gửi Zalo",),
                                                                onPressed: () async{
                                                                    lauchUrl(urlZalo);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    padding: paddingButton,
                                                                    shape: const StadiumBorder(),
                                                                    primary: whiteColor,
                                                                    onPrimary: blueColor,
                                                                    textStyle: Theme.of(context).textTheme.subtitle1
                                                                )
                                                            )
                                                        ],
                                                    )
                                                ],
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            const SizedBox(height: paddingDefault*1.2),
                            Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            "Triệu chứng",
                                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                fontWeight: FontWeight.w700
                                            )
                                        ),
                                        const SizedBox(height: paddingDefault,),
                                        SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                                children: List.generate(listSymptom.length, (i) => symptomBlock(
                                                    context, 
                                                    title: listSymptom[i]['name'], 
                                                    image: listSymptom[i]['image']
                                                )),
                                            )
                                        ),
                                        const SizedBox(height: paddingDefault*1.5),
                                        Text(
                                            "Phòng ngừa",
                                            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                                fontWeight: FontWeight.w700
                                            )
                                        ),
                                        const SizedBox(height: paddingDefault,),
                                        Column(
                                            children: List.generate(listPrevent.length, (i) => preventBlock(
                                                context,
                                                title: listPrevent[i]['name'],
                                                descriptions: listPrevent[i]['des'],
                                                image: listPrevent[i]['image']
                                            )),
                                        ),
                                        const SizedBox(height: paddingDefault/2),
                                        Align(
                                            alignment: Alignment.center,
                                            child: InkWell(
                                                child: const Text(
                                                    "Bấm vào đây để khai báo y tế",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w700,
                                                        color: blueColor
                                                    ),
                                                ),
                                                onTap: () => linkRoute(context, "Tờ khai y tế", "https://tokhaiyte.vn/"),
                                            ),
                                        )
                                    ],
                                ),
                            ),
                            const SizedBox(height: paddingDefault,),
                            const Image(
                                image: AssetImage("assets/images/banner.png"),
                                fit: BoxFit.cover,
                            ),
                        ],
                    ),
                ),
            )
        );
    }
}