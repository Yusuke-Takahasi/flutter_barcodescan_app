import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  String name = 'ここに商品名が入ります';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testGet();
  }

//関数にカーソルを当てると、関数がどの型を返してくるのかが分かる
  Future<void> testGet() async {
    //get()の処理が終わるまでawaitで待つ
    final response = await get(Uri.parse(
        'https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch?appid=dj00aiZpPUNHZ3Y0UlN5bm44RiZzPWNvbnN1bWVyc2VjcmV0Jng9MWU-&jan_code=4902505226588&in_stock=true&index=1&results=3'));
    print(response.body);
    final json = jsonDecode(response.body);
    final hits = json['hits'] as List;
    name = hits.first['name'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(name)),
    );
  }
}
