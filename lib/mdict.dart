import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'dart:typed_data';

class Header{
  int headerBytesSize;
  Header(int headerBytesSize){
    this.headerBytesSize = headerBytesSize;
  }
}

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

  Future<Header> readHeader() async {
    var list = List<int>();
    List<int> headerSizeBuffer = await readRange(0, 4);
    var origlenBuffer = ByteData(4);
    origlenBuffer.setInt32(0,  headerSizeBuffer[0], Endian.little);
    Header header = new Header(origlenBuffer.buffer.asInt32List()[0]);
    Completer c = Completer<Header>();
    c.complete(header);
    return c.future;
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
    Stream<List<int>> inputStream = file.openRead(start, end);
    List<int> result = [];
    inputStream.listen((data) {
      result.addAll(data);
    }).onDone(() {
      c.complete(result);
    }); // Decode bytes to UTF-8.
    return c.future;
  }
}
