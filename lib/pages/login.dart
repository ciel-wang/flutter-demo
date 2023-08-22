import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import '../components/customBackground.dart';
import '../components/head.dart';
import '../components/formItem.dart';
import '../components/customBtn.dart';

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
  bool _isLoginForm = true;
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

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    return CustomBackground(
        floatingActionButton: Visibility(
            visible: _isLoginForm,
            child: GestureDetector(
                child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 30),
                    child: Icon(Icons.settings,
                        size: 30, color: Color.fromRGBO(0, 0, 0, 0.5))),
                onTap: () {
                  setState(() => _isLoginForm = !_isLoginForm);
                })),
        child: Column(children: [
          const HeadComponent(),
          const Padding(padding: EdgeInsets.only(top: 100)),
          SizedBox(
              width: size.width / 2,
              child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(children: [
                    if (_isLoginForm) ...[
                      FormItem(
                        label: '用户名',
                        width: size.width / 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) return '请输入用户名';
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      FormItem(
                        label: '密码',
                        width: size.width / 2,
                        type: InputType.password,
                        validator: (value) {
                          if (value == null || value.isEmpty) return '请输入密码';
                          return null;
                        },
                      ),
                    ],
                    if (!_isLoginForm) ...[
                      FormItem(
                        label: '服务器地址',
                        width: size.width / 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入服务器地址';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      FormItem(
                        label: '端口号',
                        width: size.width / 2,
                        type: InputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return '请输入端口号';
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      FormItem(
                          label: '选择框',
                          width: size.width / 2,
                          type: InputType.select,
                          dicData: list,
                          validator: (value) {
                            if (value == null) return '请选择';
                            return null;
                          },
                          onChanged: (value) {
                            return null;
                          }),
                      const SizedBox(height: 10),
                      FormItem(
                        label: '日期',
                        width: size.width / 2,
                        type: InputType.date,
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) return '请选择日期';
                          return null;
                        },
                        controller: TextEditingController(
                            text: _date != null
                                ? "${_date?.year}-${_date?.month.toString().padLeft(2, '0')}-${_date?.day.toString().padLeft(2, '0')}"
                                : ''),
                        onTap: () {
                          _showDateTimePicker(DateTimePickerMode.date);
                        },
                      )
                    ],
                    Padding(
                        padding: const EdgeInsets.all(30),
                        child: CustomBtn(
                          size: const Size(420, 80),
                          child: Text(_isLoginForm ? '提交' : '保存',
                              style: const TextStyle(
                                  fontSize: 28, color: Colors.white)),
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              Navigator.pushNamed(context, '/index');
                            }
                          },
                        ))
                  ])))
        ]));
  }
}
