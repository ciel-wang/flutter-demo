import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum WInputSize {
  small,
  mini,
}

enum WInputType {
  text,
  password,
  select,
  date,
  time,
  datetime,
  number,
  checkbox,
  redio,
  switchs
}

const Map<WInputType, Widget> suffixIconType = {
  WInputType.password: Icon(Icons.remove_red_eye),
  WInputType.select: Icon(Icons.keyboard_arrow_down)
};
const Map<WInputType, Widget> prefixIconType = {
  WInputType.date: Icon(Icons.date_range_outlined),
  WInputType.time: Icon(Icons.date_range_outlined),
  WInputType.datetime: Icon(Icons.date_range_outlined)
};

class FormItem extends StatefulWidget {
  FormItem(
      {Key? key,
      required this.name,
      this.initialValue,
      this.width = 400,
      double? height,
      this.color = const Color.fromRGBO(00, 00, 00, 1),
      double? fontSize,
      double? labelWidth,
      required this.label,
      this.labelColor = const Color.fromRGBO(90, 93, 99, 1),
      this.size = WInputSize.small,
      this.type = WInputType.text,
      this.hintText,
      this.readOnly = false,
      this.enabled = true,
      this.maxLength,
      this.precision = 0,
      this.multiple = false,
      this.dicData,
      this.activeColor,
      this.inactiveThumbColor,
      this.border = const OutlineInputBorder(),
      this.validator,
      this.onChanged,
      this.valueTransformer,
      this.onTap,
      this.controller})
      : super(key: key) {
    this.height = height ?? (size == WInputSize.mini ? 60 : 70);
    this.fontSize = fontSize ?? (size == WInputSize.mini ? 14 : 16);
    this.labelWidth = labelWidth ?? (size == WInputSize.mini ? 60 : 70);
  }
  final String name;
  final dynamic initialValue;
  final double width;
  late final double height;
  final Color color;
  late final double fontSize;
  late final double labelWidth;
  final String label;
  final Color labelColor;
  final WInputSize size;
  final WInputType type;
  final String? hintText;
  final bool readOnly;
  final bool enabled;
  final int? maxLength;
  final int? precision;
  final bool multiple;
  final List<Map>? dicData;
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final InputBorder? border;
  final dynamic Function(dynamic)? onChanged;
  final dynamic Function(dynamic)? valueTransformer;
  final String? Function(dynamic)? validator;
  final void Function()? onTap;
  final TextEditingController? controller;

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {
  List<String> selectedItems = [];
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedItems = widget.initialValue is String
          ? widget.initialValue!.split(',')
          : widget.initialValue is List
              ? widget.initialValue
              : [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(children: [
          Positioned(
              height: widget.height - 24,
              width: widget.labelWidth,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.label,
                      style: TextStyle(
                          fontSize: widget.fontSize,
                          color: widget.labelColor)))),
          Positioned(
              left: widget.labelWidth,
              width: widget.width - widget.labelWidth - 10,
              child: (widget.type == WInputType.select)
                  ? ((widget.multiple) ? multipleDropdown() : singleDropdown())
                  : widget.type == WInputType.switchs
                      ? switchForm()
                      : widget.type == WInputType.checkbox
                          ? checkboxForm()
                          : textFormItem())
        ]));
  }

  Widget multipleDropdown() {
    return FormBuilderField(
        enabled: false,
        builder: (FormFieldState<dynamic> field) {
          return DropdownButtonFormField2<String>(
              isExpanded: true,
              hint: Text(widget.hintText ?? '请选择 ${widget.label}'),
              decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: (widget.height - widget.fontSize - 24) / 2),
                  hintText: widget.hintText ?? '请选择 ${widget.label}',
                  border: widget.border),
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
                              field.didChange(selectedItems);
                              widget.onChanged!(selectedItems);
                              setState(() {});
                              //This rebuilds the dropdownMenu Widget to update the check mark
                              menuSetState(() {});
                            },
                            child: Container(
                                height: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
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
                  elevation: 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
              iconStyleData: const IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.black45),
                  iconSize: 24,
                  openMenuIcon:
                      Icon(Icons.keyboard_arrow_up, color: Colors.black45)));
        },
        name: widget.name);
  }

  Widget singleDropdown() {
    return FormBuilderField(
        builder: (FormFieldState<dynamic> field) {
          return DropdownButtonFormField2<String>(
              isExpanded: true,
              hint: Text(widget.hintText ?? '请选择 ${widget.label}'),
              decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                      vertical: (widget.height - widget.fontSize - 24) / 2),
                  hintText: widget.hintText ?? '请选择 ${widget.label}',
                  border: widget.border),
              items: widget.dicData!
                  .map((map) => DropdownMenuItem<String>(
                      value: map['value'], child: Text(map['label'])))
                  .toList(),
              value: widget.initialValue,
              validator: widget.validator,
              onChanged: (value) {
                field.didChange(value ?? '');
                widget.onChanged!(value);
              },
              dropdownStyleData: const DropdownStyleData(
                  elevation: 3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
              iconStyleData: const IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.black45),
                  iconSize: 24,
                  openMenuIcon:
                      Icon(Icons.keyboard_arrow_up, color: Colors.black45)));
        },
        name: widget.name);
  }

  Widget textFormItem() {
    return FormBuilderTextField(
        name: widget.name,
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.type == WInputType.password,
        keyboardType: widget.type == WInputType.number
            ? TextInputType.numberWithOptions(
                decimal: widget.precision! >= 1 ? true : false)
            : TextInputType.none,
        inputFormatters: widget.type == WInputType.number
            ? [
                FilteringTextInputFormatter.allow(RegExp(widget.precision! >= 1
                    ?
                    // ignore: prefer_interpolation_to_compose_strings
                    r'^\d+\.?\d{0,' + widget.precision!.toString() + '}'
                    : r'^\d+'))
              ]
            : [],
        style: TextStyle(fontSize: widget.fontSize, color: widget.color),
        decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: (widget.height - widget.fontSize - 24) / 2,
                horizontal: 16),
            hintText: widget.hintText ??
                (widget.type == WInputType.text ||
                        widget.type == WInputType.password
                    ? '请输入 ${widget.label}'
                    : '请选择${widget.label}'),
            // suffixIcon: suffixIconType[widget.type],
            prefixIcon: prefixIconType[widget.type],
            border: widget.border),
        initialValue: widget.initialValue,
        validator: widget.validator,
        onTap: widget.onTap,
        valueTransformer: widget.valueTransformer,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        maxLength: widget.maxLength,
        controller: widget.controller);
  }

  Widget checkboxForm() {
    return FormBuilderCheckboxGroup(
        name: widget.name,
        decoration: InputDecoration(border: widget.border),
        activeColor: widget.activeColor,
        options: widget.dicData!
            .map((e) => FormBuilderFieldOption(
                value: e['value'], child: Text(e['label'])))
            .toList(),
        onChanged: widget.onChanged,
        valueTransformer: widget.valueTransformer);
  }

  Widget switchForm() {
    return SizedBox(
        height: widget.height - 36,
        child: FormBuilderSwitch(
            name: widget.name,
            decoration: InputDecoration(border: widget.border),
            valueTransformer: widget.valueTransformer,
            // initialValue: widget.initialValue ?? false,
            activeColor: widget.activeColor,
            inactiveThumbColor: widget.inactiveThumbColor,
            onChanged: widget.onChanged,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text('')));
  }
}
