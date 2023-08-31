import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ColorType { primary, sucess, warning, info }

class CustomBtn extends StatelessWidget {
  final Widget child;
  final ColorType type;
  final Size size;
  final Function()? onPressed;
  const CustomBtn(
      {Key? key,
      required this.child,
      this.type = ColorType.primary,
      this.size = const Size(260, 80),
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;
    if (type == ColorType.info) {
      // 当 type 为 ColorType.info 时设置白色背景和灰色边框
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(size.height),
        boxShadow: const [
          BoxShadow(
              color: Color.fromRGBO(154, 196, 245, 1),
              blurRadius: 10,
              spreadRadius: 2)
        ],
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(106, 176, 254, 1)),
      );
    } else {
      // 其他类型使用渐变背景
      final Map<ColorType, List<Color>> colors = {
        ColorType.primary: [
          const Color.fromRGBO(106, 176, 254, 1),
          const Color.fromRGBO(24, 109, 245, 1)
        ],
        ColorType.warning: [
          const Color.fromRGBO(255, 107, 107, 1),
          const Color.fromRGBO(245, 24, 24, 1)
        ]
      };
      decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(size.height),
          boxShadow: [
            BoxShadow(
                color: type == ColorType.primary
                    ? const Color.fromRGBO(154, 196, 245, 1)
                    : const Color.fromRGBO(250, 192, 192, 1),
                blurRadius: 10,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            colors: colors[type]!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ));
    }
    return InkWell(
        onTap: onPressed,
        child: Container(
          decoration: decoration,
          width: size.width.w,
          height: size.height.w,
          alignment: Alignment.center,
          child: child,
        ));
  }
}
