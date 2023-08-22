import 'package:flutter/material.dart';
import './routers/routers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: onGenerateRoute,
  ));
}
