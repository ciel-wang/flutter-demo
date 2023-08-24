import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../components/customBackground.dart';
import '../components/head.dart';
import '../components/formItem.dart' as my;
import '../components/customBtn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<Map> list = [
    {'value': '1', 'label': '选项一'},
    {'value': '2', 'label': '选项二'},
    {'value': '3', 'label': '选项三'}
  ];
  bool _isLoginForm = true;
  bool switchValue = false;
  void _showDateTimePicker(DateTimePickerMode pickerMode) {
    DatePicker.showDatePicker(
      context,
      locale: DateTimePickerLocale.zh_cn,
      pickerMode: pickerMode, // show TimePicker
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _formKey.currentState?.fields['date']?.didChange(
              '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: FormBuilder(
                  key: _formKey,
                  child: Column(children: [
                    if (_isLoginForm) ...[
                      my.FormItem(
                          label: '用户名',
                          name: 'userName',
                          width: size.width / 2,
                          validator: (value) {
                            if (value == null || value.isEmpty) return '请输入用户名';
                            return null;
                          }),
                      const SizedBox(height: 10),
                      my.FormItem(
                          label: '密码',
                          name: 'passWord',
                          width: size.width / 2,
                          type: my.WInputType.password,
                          validator: (value) {
                            if (value == null || value.isEmpty) return '请输入密码';
                            return null;
                          }),
                      const SizedBox(height: 10),
                      my.FormItem(
                          label: '',
                          name: 'isRememb',
                          width: size.width / 2,
                          dicData: const [
                            {'value': '1', 'label': '记住密码'}
                          ],
                          border: InputBorder.none,
                          type: my.WInputType.checkbox),
                      my.FormItem(
                          label: '选择框',
                          name: 'select',
                          width: size.width / 2,
                          type: my.WInputType.select,
                          dicData: list,
                          multiple: true,
                          validator: (value) {
                            if (value == null) return '请选择';
                            return null;
                          },
                          onChanged: (value) {
                            return null;
                          }),
                    ],
                    if (!_isLoginForm) ...[
                      my.FormItem(
                          label: '服务器地址',
                          name: 'server',
                          width: size.width / 2,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '请输入服务器地址';
                            }
                            return null;
                          }),
                      const SizedBox(height: 10),
                      my.FormItem(
                          label: '端口号',
                          name: 'port',
                          width: size.width / 2,
                          type: my.WInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) return '请输入端口号';
                            return null;
                          }),
                      const SizedBox(height: 10),
                      my.FormItem(
                          label: '启用预约',
                          name: 'enableAppointment',
                          width: size.width / 2,
                          border: InputBorder.none,
                          type: my.WInputType.switchs),
                      my.FormItem(
                          label: '人证对比',
                          name: 'enableFace',
                          width: size.width / 2,
                          border: InputBorder.none,
                          type: my.WInputType.switchs),
                      my.FormItem(
                          label: '人脸验证',
                          name: 'enableFaceVerify',
                          width: size.width / 2,
                          border: InputBorder.none,
                          type: my.WInputType.switchs),
                      my.FormItem(
                          label: '日期',
                          name: 'date',
                          width: size.width / 2,
                          type: my.WInputType.date,
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) return '请选择日期';
                            return null;
                          },
                          onTap: () {
                            _showDateTimePicker(DateTimePickerMode.date);
                          })
                    ],
                    Padding(
                        padding: const EdgeInsets.all(30),
                        child: CustomBtn(
                            size: const Size(420, 80),
                            child: Text(_isLoginForm ? '提交' : '保存',
                                style: const TextStyle(
                                    fontSize: 28, color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                debugPrint(_formKey.currentState?.instantValue
                                    .toString());
                                // Navigator.pushNamed(context, '/index');
                              }
                            }))
                  ])))
        ]));
  }
}
