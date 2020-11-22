import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mdict_flutter/mdict_flutter.dart';
import 'package:mdict_flutter/mdict.dart';
import 'package:large_file_copy/large_file_copy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _fullPathName = '';

  @override
  void initState() {
    super.initState();
    print('initState--------->');
    initDb();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initDb() async {
    String platformVersion;
    String fullPathName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await LargeFileCopy.platformVersion;
      print(platformVersion);
      // platformVersion = await MdictFlutter.platformVersion;
      fullPathName =
          await LargeFileCopy("flutter_assets/opted003.mdx").copyLargeFile;
      print('fullPathName' + fullPathName);
      this.readMdict(fullPathName);
    } on PlatformException {
      fullPathName = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _fullPathName = fullPathName;
    });
  }

  void readMdict(String fullName){
    MDict mdict = new MDict(fullName, 'utf-8', '');
  }

  @override
  Widget build(BuildContext context) {
    // rootBundle.load('data/opted003.mdx');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Copy to: $_fullPathName\n'),
        ),
      ),
    );
  }
}
