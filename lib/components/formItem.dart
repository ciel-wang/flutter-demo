import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

enum InputSize {
  small,
  mini,
}

enum InputType { text, password, select, date, time, datetime, number }

const Map<InputType, Widget> suffixIconType = {
  InputType.password: Icon(Icons.remove_red_eye),
  InputType.select: Icon(Icons.keyboard_arrow_down)
};
const Map<InputType, Widget> prefixIconType = {
  InputType.date: Icon(Icons.date_range_outlined),
  InputType.time: Icon(Icons.date_range_outlined),
  InputType.datetime: Icon(Icons.date_range_outlined)
};

class FormItem extends StatefulWidget {
  const FormItem(
      {Key? key,
      this.initialValue,
      this.width = 400,
      this.labelWidth = 70,
      required this.label,
      this.labelColor = const Color.fromRGBO(90, 93, 99, 1),
      this.color = const Color.fromRGBO(00, 00, 00, 1),
      this.size = InputSize.small,
      this.type = InputType.text,
      this.readOnly = false,
      this.enabled = true,
      this.maxLength,
      this.precision = 0,
      this.multiple = false,
      this.dicData,
      this.hintText,
      this.validator,
      this.onChanged,
      this.onTap,
      this.controller})
      : super(key: key);
  final double labelWidth;
  final String label;
  final Color labelColor;
  final Color color;
  final String? hintText;
  final double width;
  final InputSize size;
  final InputType type;
  final List<Map>? dicData;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;
  final int? precision;
  final bool multiple;
  final String? Function(Object?)? onChanged;
  final String? Function(dynamic)? validator;
  final void Function()? onTap;
  final TextEditingController? controller;
  final String? initialValue;

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  List<String> selectedItems = [];
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedItems = widget.initialValue!.split(',');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.size == InputSize.mini ? 60 : 80,
        child: Stack(children: [
          Positioned(
              height: widget.size == InputSize.mini ? 30 : 50,
              width: widget.labelWidth,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.label,
                    style: TextStyle(
                        fontSize: widget.size == InputSize.mini ? 14 : 18,
                        color: widget.labelColor),
                  ))),
          Positioned(
              left: widget.labelWidth,
              height: widget.size == InputSize.mini ? 60 : 80,
              width: widget.width - widget.labelWidth - 10,
              child: (widget.type == InputType.select)
                  ? ((widget.multiple) ? multipleDropdown() : singleDropdown())
                  : textFormItem())
        ]));
  }

  Widget multipleDropdown() {
    return DropdownButtonFormField2<String>(
        isExpanded: true,
        hint: Text(widget.hintText ?? '请选择 ${widget.label}'),
        decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.size == InputSize.mini ? 10 : 20),
            hintText: widget.hintText ?? '请选择 ${widget.label}',
            border: const OutlineInputBorder()),
        items: widget.dicData!
            .map((map) => DropdownMenuItem<String>(
                value: map['value'],
                enabled: false,
                child: StatefulBuilder(builder: (context, menuSetState) {
                  final isSelected = selectedItems.contains(map['value']);
                  return InkWell(
                      onTap: () {
                        isSelected
                            ? selectedItems.remove(map['value'])
                            : selectedItems.add(map['value']);
                        setState(() {});
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(children: [
                            if (isSelected)
                              const Icon(Icons.check_box_outlined)
                            else
                              const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(map['label']),
                            )
                          ])));
                })))
            .toList(),
        value: selectedItems.isEmpty ? null : selectedItems.last,
        selectedItemBuilder: (context) {
          List selectedLabel = widget.dicData!
              .where((item) => selectedItems.contains(item['value']))
              .map((item) => item['label'])
              .toList();
          return widget.dicData!
              .map((e) => Text(
                    selectedLabel.join(', '),
                    maxLines: 1,
                    style: TextStyle(color: widget.color),
                  ))
              .toList();
        },
        validator: widget.validator,
        onChanged: widget.onChanged,
        dropdownStyleData: const DropdownStyleData(
            offset: Offset(0, 20),
            elevation: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.black45),
            iconSize: 24,
            openMenuIcon:
                Icon(Icons.keyboard_arrow_up, color: Colors.black45)));
  }

  Widget singleDropdown() {
    return DropdownButtonFormField2<String>(
        isExpanded: true,
        hint: Text(widget.hintText ?? '请选择 ${widget.label}'),
        decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.size == InputSize.mini ? 10 : 20),
            hintText: widget.hintText ?? '请选择 ${widget.label}',
            border: const OutlineInputBorder()),
        items: widget.dicData!
            .map((map) => DropdownMenuItem<String>(
                value: map['value'], child: Text(map['label'])))
            .toList(),
        value: widget.initialValue,
        validator: widget.validator,
        onChanged: widget.onChanged,
        dropdownStyleData: const DropdownStyleData(
            offset: Offset(0, 20),
            elevation: 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)))),
        iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down, color: Colors.black45),
            iconSize: 24,
            openMenuIcon:
                Icon(Icons.keyboard_arrow_up, color: Colors.black45)));
  }

  Widget textFormItem() {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      initialValue: widget.initialValue,
      obscureText: widget.type == InputType.password,
      keyboardType: widget.type == InputType.number
          ? TextInputType.numberWithOptions(
              decimal: widget.precision! >= 1 ? true : false)
          : TextInputType.none,
      inputFormatters: widget.type == InputType.number
          ? [
              FilteringTextInputFormatter.allow(RegExp(widget.precision! >= 1
                  ?
                  // ignore: prefer_interpolation_to_compose_strings
                  r'^\d+\.?\d{0,' + widget.precision!.toString() + '}'
                  : r'^\d+'))
            ]
          : [],
      style: TextStyle(
          fontSize: widget.size == InputSize.mini ? 14 : 16,
          color: widget.color),
      decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.size == InputSize.mini ? 10 : 20,
              horizontal: 16),
          hintText: widget.hintText ??
              (widget.type == InputType.text ||
                      widget.type == InputType.password
                  ? '请输入 ${widget.label}'
                  : '请选择${widget.label}'),
          // suffixIcon: suffixIconType[widget.type],
          prefixIcon: prefixIconType[widget.type],
          border: const OutlineInputBorder()),
      validator: widget.validator,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      controller: widget.controller,
    );
  }
}
