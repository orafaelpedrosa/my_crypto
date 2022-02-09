import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {


  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //ElevatedButton(onPressed: , child: Text('ada'),),
          ],
        ),
      ),
    );
  }
}
