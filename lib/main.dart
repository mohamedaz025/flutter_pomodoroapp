// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Counterdown(),
    );
  }
}

class Counterdown extends StatefulWidget {
  const Counterdown({super.key});

  @override
  State<Counterdown> createState() => _CounterdownState();
}

//  هنا نكتب الكلاس
class _CounterdownState extends State<Counterdown> {
//  هنا نعرف المتغيرات ونضع الليست ونكتب الفونكشون
  Timer? stoptimer;
  // عمل متغير وقت ووضع قيمه له بصفر ثانية
  Duration duration = Duration(minutes: 25);
  // عمل متغير من نوع بولين تكون قيمته فولس
  bool isruning = false;
//  فونكشون بداخلها تايمة مربوط بمتغير عام
  starttimer() {
    stoptimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        //  تعريم متغير محلي وربطه بمتغير الوقت العام طرح واحد كل ثانية
        int newseconds = duration.inSeconds - 1;
        duration = Duration(seconds: newseconds);
        if (duration.inSeconds == 0) {
          stoptimer!.cancel();
          duration = Duration(minutes: 25);
          isruning = false;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // هنا نكتب الفونكشون عند بدء التشغيل
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//  هنا نكتب الاب بار والبودي والزر الاعائم
appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 16, 27, 36),
  title: Text("Pomodoro App",style: TextStyle(color: Colors.white),),
  centerTitle: true,
),
      backgroundColor: Color.fromARGB(255, 33, 40, 43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // لعمل دائرة تحميل
              CircularPercentIndicator(
                // نصف قطر الدائره
                radius: 120.0,
                progressColor: Color.fromARGB(255, 255, 85, 113),
                backgroundColor: Colors.grey,
                // عرض الخط
                lineWidth: 8.0,
                //  القيمة التي ينقص منها
                percent: duration.inMinutes / 25,
                //  الانيميشون
                animation: true,
                //  الانيميشون
                animateFromLastPercent: true,
                //  كلما زاد الرقم زادة النعومة
                animationDuration: 1000,
                center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")} : ${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
              ),
            ],
          ),
          SizedBox(height: 27),
          //  قاعدة ايف المختصرة اذا كان المتغير من نوع بولين ترو او فولس يظهر ازرار معينة
          isruning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // اذا كان التيمر يعمل ينفذ هوت ريفريش ثم يوقف التايمر
                        if (stoptimer!.isActive) {
                          setState(() {
                            stoptimer!.cancel();
                          });
                        } else {
                          // اذا كان التايمر متوقف يشغل الفونكشون التي بداخلها التايمر
                          starttimer();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: Text(
                        // اذا كان التايمر يعمل يظهر كلمة ايقاف واذا كان لايعمل يظهر تخطي
                        (stoptimer!.isActive) ? " Stop " : "resume",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 22),
                    ElevatedButton(
                      onPressed: () {
                        //  عمل توقيف للتايمر
                        stoptimer!.cancel();
                        // عمل هوت ريفريش ثم جعل المتغير العام للوقت يساوي صفر وجعل المتغير البولين بفولس
                        setState(() {
                          duration = Duration(minutes: 25);
                          isruning = false;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                      child: Text(
                        "CAncel",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                    )
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    //  بدء تشغيل الفونكشون التي بداخلها تايمر بيذود 1 كل ثانية
                    starttimer();
                    // تحويل المتغير البولين الي ترو لاظهار الاذرار الاخري
                    isruning = true;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text(
                    "start Studying",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                )
        ],
      ),
    );
  }
}
