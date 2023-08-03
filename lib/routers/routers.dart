import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/sign.dart';
import '../pages/login.dart';
import '../pages/index.dart';
// import '../pages/sign.dart';

final routes = {
  '/': (contxt) => const LoginPage(),
  '/index': (contxt) => const IndexPage(),
  // '/': (contxt) => MyApp(),
};
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
};
