import 'package:flutter/material.dart';
import './routers/routers.dart';
import 'utils/shared_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  String value = await SharedData.init();
  if (value == 'ok') {
    runApp(ScreenUtilInit(
      designSize: const Size(1365, 1024),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: onGenerateRoute,
        );
      },
    ));
  }
}
