import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final String? backgroundImage;
  final Widget child;
  const CustomBackground({
    Key? key,
    this.backgroundImage,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgroundImage ?? 'static/img/bg1.png'),
                  fit: BoxFit.fill)),
          child:
              SizedBox(width: size.width, height: size.height, child: child)),
    );
  }
}
