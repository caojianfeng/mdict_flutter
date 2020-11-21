import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mdict_flutter/mdict_flutter.dart';
import 'package:mdict_flutter/mdict.dart';

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

  test('MDict', () {
    print('test MDict.construct');
    MDict mdict = new MDict('example/data/opted003.mdx', 'utf-8', '');
    // mdict.readHeader();
    // expect(await MDict, '42');
  });
}
