import 'package:flutter/material.dart';
import '../pages/login.dart';
import '../pages/index.dart';
import '../pages/sign.dart';
import '../pages/recordes.dart';
import '../pages/face.dart';
// import '../pages/test.dart';

final routes = {
  '/': (contxt) => const LoginPage(),
  '/login': (contxt) => const LoginPage(),
  '/index': (contxt) => const IndexPage(),
  '/sign': (contxt) => const SignPage(),
  '/recordes': (contxt) => const RecordesPage(),
  '/face': (contxt) => const Face(),
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
