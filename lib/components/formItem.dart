import 'package:flutter/material.dart';

enum InputSize {
  small,
  mini,
}

enum InputType { text, password, select, date, time, datetime }

const Map<InputType, Widget> suffixIconType = {
  InputType.password: Icon(Icons.remove_red_eye),
  InputType.select: Icon(Icons.keyboard_arrow_down)
};
const Map<InputType, Widget> prefixIconType = {
  InputType.date: Icon(Icons.date_range_outlined),
  InputType.time: Icon(Icons.date_range_outlined),
  InputType.datetime: Icon(Icons.date_range_outlined)
};

class FormItem extends StatelessWidget {
  final double labelWidth;
  final String label;
  final String? hintText;
  final double width;
  final InputSize size;
  final InputType type;
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
      this.labelWidth = 70,
      required this.label,
      this.size = InputSize.small,
      this.type = InputType.text,
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
      height: size == InputSize.mini ? 60 : 80,
      child: Stack(
        children: [
          Positioned(
              height: size == InputSize.mini ? 30 : 50,
              width: labelWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(fontSize: size == InputSize.mini ? 14 : 18),
                ),
              )),
          Positioned(
              left: labelWidth,
              height: size == InputSize.mini ? 60 : 80,
              width: width - labelWidth - 10,
              child: type == InputType.select
                  ? DropdownButtonFormField(
                      elevation: 0,
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.all(size == InputSize.mini ? 10 : 20),
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
                      obscureText: type == InputType.password,
                      style:
                          TextStyle(fontSize: size == InputSize.mini ? 14 : 16),
                      decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                              EdgeInsets.all(size == InputSize.mini ? 10 : 20),
                          hintText: hintText ??
                              (type == InputType.text ||
                                      type == InputType.password
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
