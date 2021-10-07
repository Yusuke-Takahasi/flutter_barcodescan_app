import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'qr_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:translator/translator.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  String name = 'ここに商品名が入ります';
  String image = '';
  final url = "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch";
  final appid =
      '?appid=dj00aiZpPUNHZ3Y0UlN5bm44RiZzPWNvbnN1bWVyc2VjcmV0Jng9MWU-';
  String jancode = '&jan_code=';
  String itemnumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  GoogleTranslator translator = GoogleTranslator();

  String text = '';

  Future<void> translate() async {
    final output = await translator.translate(name, to: 'en');
    setState(() {
      text = output.text;
    });
  }

//関数にカーソルを当てると、関数がどの型を返してくるのかが分かる
  Future<void> testGet() async {
    //get()の処理が終わるまでawaitで待つ
    final response = await get(Uri.parse(url + appid + jancode + itemnumber));
    print(response.body);
    final json = jsonDecode(response.body);
    final hits = json['hits'] as List;
    name = hits.first['name'];
    await translate();
    image = hits.first['image']['medium'];
    setState(() {});
  }

  Future<void> scanBarcodeNormal() async {
    late String barcodeScanRes;
    //tryは例外処理の時に呼び出す
    //on の後に例外の処理の時の挙動を記述する
    try {
      //パッケージ内のFlutterBarcodeScanner.scanBarcodeで指定されているパラメータをbarcodeScanResに代入している
      //awaitは、指定したパラメータを取得できるまで、次の処理を待っている
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    //barcodeScanResをitemnumberに代入している
    itemnumber = barcodeScanRes;
    if (!mounted) return;
    //setStateは呼ばれたタイミングで画面を再描画する関数
    //書かない場合、取得した変数などを内部では持っているが、描画しない状態になる。
    testGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          if (image.isNotEmpty) Image.network(image),
          ElevatedButton(
            onPressed: scanBarcodeNormal,
            child: Text('バーコードスキャン'),
          ),
        ],
      )),
    );
  }
}
