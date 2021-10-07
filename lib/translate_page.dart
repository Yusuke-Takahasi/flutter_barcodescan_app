import 'dart:convert';
import 'package:http/http.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({Key? key}) : super(key: key);

  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  GoogleTranslator translator = GoogleTranslator();

  String text = 'Hello, How are you?';

  void translate() {
    translator.translate(text, to: 'ja').then((output) {
      setState(() {
        text = output.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Trancelation'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(text),
              ElevatedButton(
                onPressed: () {
                  translate();
                },
                child: Text('Translate the text'),
              )
            ],
          )),
    );
  }
}
