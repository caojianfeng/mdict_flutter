import 'dart:io';
import 'dart:convert';
import 'dart:async';

class MDict {
  String fname;
  String encoding;
  String passcode;
  String header;
  MDict(String fname, String encoding, String passcode) {
    this.fname = fname;
    this.encoding = encoding.toUpperCase();
    this.passcode = passcode;
  }

  Future<List<int>> readHeaderSize() async{
    return readRange(0,4);
  }

  Future<List<int>> readRange(int start, int end) async {
    print('readRange($start,$end)');
    File file = new File(this.fname);
    if (file == null || !file.existsSync()) {
      throw ("FileNotExistsError");
    }
    if (start < 0) {
      throw RangeError.range(start, 0, file.lengthSync());
    }
    if (end > file.lengthSync()) {
      throw RangeError.range(end, 0, file.lengthSync());
    }
    Completer c = Completer<List<int>>();
    print('openRead(){');
    Stream<List<int>> inputStream = file.openRead(start, end);
    print('openRead()}');
    List<int> result = [];
    inputStream.listen((data) {
      print('listen:$data' );
      result.addAll(data);
    }).onDone(() {
      print('onDone:$result' );
      c.complete(result);
    }); // Decode bytes to UTF-8.
    return c.future;
  }
}
