import 'package:flutter/material.dart';

enum Size {
  small,
  mini,
}

enum Type { text, password, select, date, time, datetime }

const Map<Type, Widget> suffixIconType = {
  Type.password: Icon(Icons.remove_red_eye),
  Type.select: Icon(Icons.keyboard_arrow_down)
};
const Map<Type, Widget> prefixIconType = {
  Type.date: Icon(Icons.date_range_outlined),
  Type.time: Icon(Icons.date_range_outlined),
  Type.datetime: Icon(Icons.date_range_outlined)
};

class FormItem extends StatelessWidget {
  final double labelWidth;
  final String label;
  final String? hintText;
  final double width;
  final Size size;
  final Type type;
  final List<Map>? dicData;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;
  final String? Function(Object?)? onChanged;
  final String? Function(dynamic)? validator;
  final void Function()? onTap;
  final TextEditingController? controller;

  const FormItem(
      {Key? key,
      this.width = 400,
      this.labelWidth = 100,
      required this.label,
      this.size = Size.small,
      this.type = Type.text,
      this.readOnly = false,
      this.enabled = true,
      this.maxLength,
      this.dicData,
      this.hintText,
      this.validator,
      this.onChanged,
      this.onTap,
      this.controller})
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
                      validator: validator,
                      onChanged: onChanged)
                  : TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: type == Type.password,
                      style: TextStyle(fontSize: size == Size.mini ? 14 : 16),
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.all(size == Size.mini ? 10 : 20),
                          hintText: hintText ??
                              (type == Type.text || type == Type.password
                                  ? '请输入 $label'
                                  : '请选择$label'),
                          suffixIcon: suffixIconType[type],
                          prefixIcon: prefixIconType[type],
                          border: const OutlineInputBorder()),
                      validator: validator,
                      onTap: onTap,
                      readOnly: readOnly,
                      enabled: enabled,
                      maxLength: maxLength,
                      controller: controller,
                    ))
        ],
      ),
    );
  }
}
