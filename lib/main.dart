import 'dart:html';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:coronadetect/Model/Note.dart';
import 'package:coronadetect/Model/SqliteHandler.dart';
import 'package:coronadetect/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => SplashPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/second': (context) => MyHomePage(),
        },
        theme: ThemeData(
            unselectedWidgetColor: Colors.white,
            primarySwatch: Colors.amber,
            primaryColor: Colors.amber,
            accentColor: Colors.orange,
            primaryColorLight: Colors.orange,
            scaffoldBackgroundColor: Colors.white,
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: Colors.orange))));
  }
}

bool isPlayed = false;

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    isPlayed = false;
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      // AsyncSnapshot<Your object type>
      var styleFrom = TextButton.styleFrom(
        primary: Colors.black87,
        textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        backgroundColor: Colors.amber,
        padding:
            EdgeInsets.only(right: 30.0, left: 30.0, top: 15.0, bottom: 15.0),
      );
      return Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  'Corona Tester',
                  style: TextStyle(fontSize: 60, color: Colors.amber),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: TextButton(
                      style: styleFrom,
                      onPressed: () {
                        loadMusic();
                        new Future.delayed(const Duration(seconds: 5), () {
                          Navigator.pushReplacementNamed(context, '/second');
                        });
                      },
                      child: Text('تست کرونا'),
                    ),
                  ),
                  TextButton(
                    style: styleFrom,
                    onPressed: () {
                      new Future.delayed(const Duration(seconds: 5), () {
                        Navigator.pushReplacementNamed(context, '/second');
                      });
                    },
                    child: Text('مشاهده تاریخچه'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

Future loadMusic() async {
  print('WTF');
  if (!isPlayed) {
    print('WTFisPlayed');
    final assetsAudioPlayer = new AssetsAudioPlayer();
    assetsAudioPlayer.open(Audio.file("audio/small.mp3"), autoStart: true);
    isPlayed = true;
    new Future.delayed(const Duration(seconds: 10), () {
      assetsAudioPlayer.stop();
    });
  }
  return '';
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

enum YesOrNo { yes, no }

class _MyHomePageState extends State<MyHomePage> {
  YesOrNo? q1 = YesOrNo.no;
  YesOrNo? q2 = YesOrNo.no;
  YesOrNo? q3 = YesOrNo.no;
  YesOrNo? q4 = YesOrNo.no;
  YesOrNo? q5 = YesOrNo.no;
  String dropdownValue = 'اقا';
  @override
  void initState() {}
  var styleFrom = TextButton.styleFrom(
    primary: Colors.black87,
    textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    backgroundColor: Colors.amber,
    padding: EdgeInsets.only(right: 30.0, left: 30.0, top: 15.0, bottom: 15.0),
  );
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            title: Text(
              'علائمی که دارید را انتخاب کنید:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextField(
                      controller: myController,
                      style: TextStyle(color: Colors.amber),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        focusColor: Colors.amber,
                        fillColor: Colors.amber,
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 0.0),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'نام و نام خانوادگی',
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '1. احساس تب و لرز؟',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'بله',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.yes,
                            groupValue: q1,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q1 = value;
                              });
                            },
                          ),
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'خیر',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.no,
                            groupValue: q1,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q1 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '2. احساس خستگی زیاد',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'بله',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.yes,
                            groupValue: q2,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q2 = value;
                              });
                            },
                          ),
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'خیر',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.no,
                            groupValue: q2,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q2 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '3. سرفه خشک',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'بله',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.yes,
                            groupValue: q3,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q3 = value;
                              });
                            },
                          ),
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'خیر',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.no,
                            groupValue: q3,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q3 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '4. گلو درد',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'بله',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.yes,
                            groupValue: q4,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q4 = value;
                              });
                            },
                          ),
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'خیر',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.no,
                            groupValue: q4,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q4 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '5. از دست دادن طعم یا بو',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'بله',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.yes,
                            groupValue: q5,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q5 = value;
                              });
                            },
                          ),
                          RadioListTile<YesOrNo>(
                            dense: true,
                            title: const Text(
                              'خیر',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            value: YesOrNo.no,
                            groupValue: q5,
                            onChanged: (YesOrNo? value) {
                              setState(() {
                                q5 = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.amber,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['اقا', 'خانم']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    style: styleFrom,
                    onPressed: () {
                      calculateAndSave(
                          myController.text, dropdownValue, q1, q2, q3, q4, q5);
                    },
                    child: Text('مشاهده تاریخچه'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

void calculateAndSave(name, gender, q1, q2, q3, q4, q5) async {
  var sum = 0;
  if (q1 == YesOrNo.yes) {
    sum += 25;
  }
  if (q2 == YesOrNo.yes) {
    sum += 25;
  }
  if (q3 == YesOrNo.yes) {
    sum += 25;
  }
  if (q4 == YesOrNo.yes) {
    sum += 25;
  }
  if (q5 == YesOrNo.yes) {
    sum += 25;
  }
  print(name + sum.toString());
  // Create a Dog and add it to the dogs table
  DBProvider.db
      .newClient(Client(name: name, gender: gender, number: sum.toString()));
}
