import 'package:flutter/material.dart';

enum Size {
  small,
  mini,
}

enum Type { text, password, select, date, time }

class FormItem extends StatelessWidget {
  final double labelWidth;
  final String label;
  final String? hintText;
  final double width;
  final Size size;
  final Type type;
  final List<Map>? dicData;
  final String? Function(Object?)? onChanged;
  final String? Function(String?)? validator;
  final String? Function(Object?)? validator2;

  const FormItem(
      {Key? key,
      this.width = 400,
      this.labelWidth = 100,
      required this.label,
      this.size = Size.small,
      this.type = Type.text,
      this.dicData,
      this.hintText,
      this.validator,
      this.validator2,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: size == Size.mini ? 60 : 80,
      child: Stack(
        children: [
          Positioned(
              height: size == Size.mini ? 30 : 50,
              width: labelWidth,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(fontSize: size == Size.mini ? 14 : 18),
                ),
              )),
          Positioned(
              left: labelWidth,
              height: size == Size.mini ? 60 : 80,
              width: width - labelWidth - 10,
              child: type == Type.select
                  ? DropdownButtonFormField(
                      elevation: 0,
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.all(size == Size.mini ? 10 : 20),
                          hintText: hintText ?? '请选择 $label',
                          border: const OutlineInputBorder()),
                      items: dicData?.map((map) {
                        return DropdownMenuItem(
                          value: map['value'],
                          child: Text(map['label']),
                        );
                      }).toList(),
                      validator: validator2,
                      onChanged: onChanged)
                  : TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: type == Type.password,
                      style: TextStyle(fontSize: size == Size.mini ? 14 : 16),
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.all(size == Size.mini ? 10 : 20),
                          hintText: hintText ?? '请输入 $label',
                          border: const OutlineInputBorder()),
                      validator: validator,
                    ))
        ],
      ),
    );
  }
}
