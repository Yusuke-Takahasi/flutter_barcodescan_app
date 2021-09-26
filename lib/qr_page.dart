import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

//strでStatefulWidgetのスニペット、stlでStatelessWidgetのスニペット

class QrPage extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  String _scanBarcode = 'Unknown';
//initStateはいつ呼んでもいい
//initStateの後に処理を記述する。なければ記入する必要はない。
  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    //setStateの前に呼ぶ
    if (!mounted) return;
    //_scanBarcode = barcodeScanRes;をsetStateの中に書く必要はない
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
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
    //barcodeScanResを_scanBarcodeに代入している
    _scanBarcode = barcodeScanRes;
    if (!mounted) return;
    //setStateは呼ばれたタイミングで画面を再描画する関数
    //書かない場合、取得した変数などを内部では持っているが、描画しない状態になる。
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Material AppでWidgetのデフォルト値を呼び出している
    //いきなりScafoldを呼び出しても情報が足りないので、描画できない
    return Scaffold(
        appBar: AppBar(title: const Text('Barcode scan')),
        body: Builder(builder: (BuildContext context) {
          return Container(
              alignment: Alignment.center,
              //通常はColunmmを使うが、Flexを使っている
              child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.center,
                  //childrenは配列を入れる< >には型を指定している今回は<Widget>を指定している。
                  children: <Widget>[
                    ElevatedButton(
                        //scanBarcodeNormal関数を呼び出している
                        onPressed: scanBarcodeNormal,
                        child: Text('Start barcode scan')),
                    //アロー関数は{ }を省略できる記法
                    //scanQR関数を無名関数に代入している
                    //無名関数とは色んな関数を無名関数の中に入れて、処理を追加することができる書き方
                    ElevatedButton(
                        onPressed: () => scanQR(),
                        child: Text('Start QR scan')),
                    ElevatedButton(
                        onPressed: () => startBarcodeScanStream(),
                        child: Text('Start barcode scan stream')),
                    //関数で取得した値をテキストとして画面に表示させている
                    Text('Scan result : $_scanBarcode\n',
                        style: TextStyle(fontSize: 20))
                  ]));
        }));
  }
}
