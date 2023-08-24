import 'dart:math';

import 'package:flutter/material.dart';

// 自定义五星好评样式
class CustomRating extends StatelessWidget {
  final double value;
  final int count;
  final int maxValue;
  final IconData icon;
  final Color selectedColor;
  final Color unSelectColor;
  final double size;
  const CustomRating(
      {super.key,
      required this.value,
      this.count = 5,
      this.maxValue = 5,
      this.icon = Icons.star,
      this.selectedColor = Colors.red,
      this.unSelectColor = Colors.grey,
      this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [initWidget(), getSelectWidget()]);
  }

  Widget initWidget() {
    return Row(
        children: List.generate(count, (index) {
      return Icon(icon, color: unSelectColor, size: size);
    }));
  }

  Widget getSelectWidget() {
    double oneValue = maxValue / count;
    int selectCount = min((value / oneValue).floor(), count - 1);
    double surplus = (value - selectCount * oneValue) / oneValue;
    return Row(
        children: List.generate(selectCount + 1, (index) {
      if (index < selectCount) {
        return Icon(icon, color: selectedColor, size: size);
      }
      return ClipRect(
          clipper: myClipper(width: surplus * size),
          child: Icon(icon, color: selectedColor, size: size));
    }));
  }
}

// ignore: camel_case_types
class myClipper extends CustomClipper<Rect> {
  final double width;
  myClipper({required this.width});
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(covariant myClipper oldClipper) {
    return width != oldClipper.width;
  }
}
