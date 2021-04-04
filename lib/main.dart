import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isConnected = "";
  Icon _icon = Icon(Icons.check);

  isConnected() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty) {
        setState(() {
          _isConnected = "You Are Connected";
          _icon = Icon(Icons.check);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _isConnected = "Your Are Not Connected";
        _icon = Icon(Icons.network_check);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isConnected();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Icon(Icons.account_tree_outlined),
        ],
        title: Text(
          "Connection Checker",
        ),
        brightness: Brightness.light,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isConnected.toString(),
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isConnected,
        tooltip: 'Check Connection',
        child: _icon,
      ),
    );
  }
}
