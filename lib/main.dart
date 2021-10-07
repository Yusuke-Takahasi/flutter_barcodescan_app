import 'dart:async';
import 'dart:convert' as convert;
import 'package:flutter_barcodescan_app/qr_page.dart';
import 'package:flutter_barcodescan_app/sample_page.dart';
import 'package:flutter_barcodescan_app/translate_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

//main関数は実行すると最初に呼ばれる関数
//runAppはアプリのrootを決める関数
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SamplePage(),
    );
  }
}
