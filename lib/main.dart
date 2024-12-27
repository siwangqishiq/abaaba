import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AbaUtil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '喵语转换器'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var editorController = TextEditingController();
  var outputController = TextEditingController();

  var isCopyBtnEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: editorController,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: '输入内容',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                )
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: (){
                String inputContent = editorController.text;
                if(Aba.isOnlyAba(inputContent)){ //decode
                  String decodeStr = Aba.decode(inputContent);
                  outputController.text = decodeStr;
                }else{//encode
                  String encodeStr = Aba.encode(inputContent);
                  outputController.text = encodeStr;
                }

                bool isEnable = outputController.text.isNotEmpty;
                if(isEnable != isCopyBtnEnable){
                  setState(() {
                    isCopyBtnEnable = isEnable;
                  });
                }
              },
              child: const Text('开始转换'),
            ),
            const SizedBox(
              height: 20,
            ),

            SingleChildScrollView(
              child: TextField(
                controller: outputController,
                enabled: false,
                minLines: 1,
                maxLines: 8,
                onChanged: (value) {
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment:Alignment.bottomRight,
              child: OutlinedButton(
                onPressed: isCopyBtnEnable?(){
                  Clipboard.setData(ClipboardData(text: outputController.text));
                }:null,
                child: const Text('复制'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
