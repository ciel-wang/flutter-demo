import 'package:flutter/material.dart';
import './routers/routers.dart';
import 'utils/shared_data.dart';

void main() async {
  String value = await SharedData.init();
  if (value == 'ok') {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    ));
  }
}
