import 'package:flutter/material.dart';
import '../components/customBackground.dart';
import '../components/head.dart';
import '../components/formItem.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<Map> list = [
    {'value': '1', 'label': '选项一'},
    {'value': '2', 'label': '选项二'},
    {'value': '3', 'label': '选项三'}
  ];
  DateTime? _date;
  void _showDateTimePicker(DateTimePickerMode pickerMode) {
    DatePicker.showDatePicker(
      context,
      locale: DateTimePickerLocale.zh_cn,
      pickerMode: pickerMode, // show TimePicker
      onConfirm: (dateTime, List<int> index) {
        setState(() => _date = dateTime);
      },
    );
  }

  // showPickerModal(BuildContext context) async {
  //   final result = await Picker(
  //       adapter: PickerDataAdapter<String>(pickerData: [1, 2, 3, 4]),
  //       changeToFirst: true,
  //       hideHeader: false,
  //       height: 300,
  //       itemExtent: 50,
  //       selectedTextStyle: TextStyle(color: Colors.blue),
  //       onConfirm: (picker, value) {
  //         print(value.toString());
  //         print(picker.adapter.text);
  //       }).showModal(this.context); //_sca
  //   print("result: $result"); // ffoldKey.currentState);
  // }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    return CustomBackground(
        child: Column(
      children: [
        const HeadComponent(),
        const Padding(padding: EdgeInsets.only(top: 100)),
        SizedBox(
          width: size.width / 2,
          child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  FormItem(
                    label: '用户名',
                    width: size.width / 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) return '请输入用户名';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormItem(
                    label: '密码',
                    width: size.width / 2,
                    type: Type.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) return '请输入密码';
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormItem(
                      label: '选择框',
                      width: size.width / 2,
                      type: Type.select,
                      dicData: list,
                      validator: (value) {
                        if (value == null) return '请选择';
                        return null;
                      },
                      onChanged: (value) {
                        return null;
                      }),
                  FormItem(
                    label: '日期',
                    width: size.width / 2,
                    type: Type.date,
                    readOnly: true,
                    validator: (value) {
                      if (value == null) return '请选择日期';
                      return null;
                    },
                    controller: TextEditingController(
                        text: _date != null
                            ? "${_date?.year}-${_date?.month.toString().padLeft(2, '0')}-${_date?.day.toString().padLeft(2, '0')}"
                            : ''),
                    onTap: () {
                      _showDateTimePicker(DateTimePickerMode.date);
                    },
                  ),
                  FormItem(
                    label: '选择',
                    width: size.width / 2,
                    type: Type.date,
                    readOnly: true,
                    onTap: () {
                      // showPickerModal(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Navigator.pushNamed(context, '/index');
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              )),
        )
      ],
    ));
  }
}
