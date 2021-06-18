import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/models/documents/document.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String validDocumentJson = '[{"insert":"This is the content of the document\\n"}]';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Working:"),
                const SizedBox(height: 6.0),
                CupertinoButton.filled(onPressed: parseJsonDocumentOnMainThread, child: const Text("parseJsonDocumentOnMainThread()")),
                const SizedBox(height: 20.0),
                const Text("Fatal crash:"),
                const SizedBox(height: 6.0),
                CupertinoButton.filled(onPressed: parseJsonDocumentWithCompute, child: const Text("parseJsonDocumentWithCompute()")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  parseJsonDocumentWithCompute() async {
    Document document = await compute(convertJsonToQuillDocumentInternal, validDocumentJson);
  }

  parseJsonDocumentOnMainThread() {
    Document document = Document.fromJson(jsonDecode(validDocumentJson));
  }
}

Document convertJsonToQuillDocumentInternal(final String json) => Document.fromJson(jsonDecode(json));
