import 'dart:html';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

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
            primarySwatch: Colors.blue,
            primaryColor: Colors.green,
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
    new Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacementNamed(context, '/second');
    });
    return FutureBuilder(
        future: loadMusic(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // AsyncSnapshot<Your object type>
          return Scaffold(
            backgroundColor: Colors.green,
            body: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  new Image.asset('images/test.jpg'),
                  Center(
                    child: Text(
                      'Flutter Learning',
                      style: TextStyle(fontSize: 50),
                    ),
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _clicked = 0;
  String value = '';

  final myController = TextEditingController();

  changeValueInput() {
    setState(() {
      _counter = myController.text.length;
    });
  }

  @override
  void initState() {
    myController.addListener(changeValueInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        //        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: myController,
              onChanged: changeValueInput(),
              decoration: new InputDecoration(
                labelText: "Enter Email",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.number,
              style: new TextStyle(fontFamily: "Poppins", color: Colors.red),
            ),
            Text(
              'asfasfasf',
              style: TextStyle(color: Colors.red),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 25.0),
              child: Icon(
                Icons.accessibility,
                color: Colors.green,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_clicked',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _clicked++;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          fixedColor: Colors.green,
          items: [
            BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text("Search"),
              icon: Icon(Icons.search),
            ),
          ],
          onTap: (int indexOfItem) {
            final snackBar = SnackBar(
              content: Text("Clicked " + indexOfItem.toString()),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'GeeksforGeeks',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.undo),
              title: Text('Item 1'),
              onTap: () {
                final snackBar = SnackBar(
                  content: Text("Clicked Item 1"),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            ListTile(
              title: Text('Item 2'),
            ),
          ],
        ),
      ),
    );
  }
}
