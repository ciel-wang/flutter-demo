import 'package:flutter/material.dart';
import './routers/routers.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: onGenerateRoute,
  ));
}
