import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(MyApp());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterplus = 0;
  int _counterminus = 0;
  Duration duration = Duration();
  Timer? timer;
  bool started= false;


  void _incrementCounter() {
    setState(() {
      _counterplus++;
    });
  }

  void start(){
    started = true;
    timer=Timer.periodic(Duration(seconds: 1), (_) =>addTime());}

  void reset() {

    setState(() {
      duration = Duration();
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SafeArea(
              child: Wrap(
                children: [Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'HOME',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(10)),
                            height: 200,
                            width: 200,

                            child: Center(
                                child: Text('$_counterplus',
                                    style: TextStyle(
                                        fontSize: 100, color: Colors.white))),
                          ),
                          onPressed: _incrementCounter,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _counterplus < 1
                                    ? _counterplus = 0
                                    : _counterplus--;
                              });
                            },
                            child: Text('-1',style: TextStyle(fontSize: 35,color: Colors.white),)),

                      ],
                    ),
                    Column(
                      children: [
                        buildTime(),
                        Row(

                          children: [
                            RawMaterialButton(shape: const StadiumBorder(side: BorderSide(color: Colors.white,strokeAlign: 10)),
                                onPressed: (){
                                  (!started)? start():stopTimer();
                                }, child: Text((!started)? 'Start':'Pause',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                            SizedBox(width:25,),
                            RawMaterialButton(shape: const StadiumBorder(side: BorderSide(color: Colors.white,strokeAlign: 10)),
                                onPressed: (){
                                  reset();
                                  _counterplus = 0;
                                  _counterminus = 0;
                                }, child: Text('Reset',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold))),
                          ],
                        )
                      ],),

                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('GUEST',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _counterminus++;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(color:Colors.blue,borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                                  '$_counterminus',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 100),
                                )),
                            height: 200,
                            width: 200,

                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                _counterminus < 1
                                    ? _counterminus = 0
                                    : _counterminus--;
                              });
                            },
                            child: Text('-1',style: TextStyle(fontSize: 35,color: Colors.white),)
                        )
                      ],
                    ),
                  ],
                ),

                ],
              ),
            )
          ],
        ));
  }

  buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60))
    ;
    final hours = twoDigits(duration.inHours.remainder(60))
    ;
    return Text(

      '$hours:$minutes:$seconds',
      style: TextStyle(fontSize: 40, color: Colors.white,fontWeight: FontWeight.bold),
    );
  }

  addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if(seconds<0){timer?.cancel();}
      else {
        duration = Duration(seconds: seconds);}
    });
  }

  void stopTimer() {
    timer!.cancel();
    setState(() {
      started = false;
    });

  }}
