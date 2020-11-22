import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mdict_flutter/mdict_flutter.dart';
import 'package:mdict_flutter/mdict.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  const MethodChannel channel = MethodChannel('mdict_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    print('setup');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    print('tearDown');
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    print('test getPlatformVersion');
    expect(await MdictFlutter.platformVersion, '42');
  });

  test('MDict', () async {
    print('test MDict.construct');
    MDict mdict = await new MDict('test/opted003.mdx', 'utf-8', ''); // AndroidStudio
    // MDict mdict = await new MDict('opted003.mdx', 'utf-8', ''); // terminal
    Header header = await mdict.readHeader();
    print('header.headerBytesSize:${header.headerBytesSize}');
    // mdict.readHeader();
    // expect(await MDict, '42');
  });
}
