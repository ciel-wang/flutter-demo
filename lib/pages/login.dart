import 'package:flutter/material.dart';
// import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_demo/utils/shared_data.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/custom_background.dart';
import '../components/head.dart';
import '../components/form_item.dart' as my;
import '../components/custom_btn.dart';

// import '../utils/http.dart';
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

  Map<String, dynamic> form = {
    'userName': '',
    'passWord': '',
    'isRememb': [],
    'serverIp': SharedData.getString(SharedKey.serverIp) ?? '',
    'port': SharedData.getString(SharedKey.port) ?? '',
    'enableAppointment':
        SharedData.getBool(SharedKey.enableAppointment) ?? false,
    'enableFace': SharedData.getBool(SharedKey.enableFace) ?? false,
    'enableFaceVerify': SharedData.getBool(SharedKey.enableFaceVerify) ?? false
  };
  @override
  void initState() {
    super.initState();
    if (SharedData.getBool(SharedKey.isRememb) == true) {
      form['userName'] = SharedData.getString(SharedKey.userName);
      form['passWord'] = SharedData.getString(SharedKey.passWord);
      form['isRememb'] = [true];
    }
  }

  void loginSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      Map<String, dynamic> newForm = _formKey.currentState!.value;
      form.addAll(newForm);
      if (!_isLoginForm) {
        SharedData.saveString(SharedKey.serverIp, form['serverIp']);
        SharedData.saveString(SharedKey.port, form['port']);
        SharedData.saveBool(
            SharedKey.enableAppointment, form['enableAppointment'] ?? false);
        SharedData.saveBool(SharedKey.enableFace, form['enableFace'] ?? false);
        SharedData.saveBool(
            SharedKey.enableFaceVerify, form['enableFaceVerify'] ?? false);
        setState(() {
          _isLoginForm = !_isLoginForm;
        });
      } else {
        if (!form.containsKey('serverIp') || form['serverIp'] == null) {
          setState(() {
            _isLoginForm = !_isLoginForm;
          });
        } else {
          // HttpUtil().post('/api/visit/login', data: {
          //   'userName': 'admin',
          //   'password': 'qazwsx',
          //   'companyCode': '000000'
          // }).then((res) {
          //   // print(res.toString());
          // });
          if (form.containsKey('isRememb') && form['isRememb']) {
            SharedData.saveString(SharedKey.userName, form['userName']);
            SharedData.saveString(SharedKey.passWord, form['passWord']);
            SharedData.saveBool(SharedKey.isRememb, form['isRememb'] ?? false);
          } else {
            SharedData.removeKey(SharedKey.isRememb);
          }
          Navigator.pushNamed(context, '/index');
        }
      }
    }
  }
  // void _showDateTimePicker(DateTimePickerMode pickerMode) {
  //   DatePicker.showDatePicker(
  //     context,
  //     locale: DateTimePickerLocale.zh_cn,
  //     pickerMode: pickerMode, // show TimePicker
  //     onConfirm: (dateTime, List<int> index) {
  //       setState(() {
  //         _formKey.currentState?.fields['date']?.didChange(
  //             '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}');
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    debugPrint('${size.width},${size.height}');
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
          Expanded(
              child: FormBuilder(
                  key: _formKey,
                  initialValue: form,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isLoginForm) ...[
                          my.FormItem(
                              key: const ValueKey('userName'),
                              label: '用户名',
                              name: 'userName',
                              width: size.width / 2,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '请输入用户名';
                                }
                                return null;
                              }),
                          my.FormItem(
                              key: const ValueKey('passWord'),
                              label: '密码',
                              name: 'passWord',
                              width: size.width / 2,
                              type: my.WInputType.password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '请输入密码';
                                }
                                return null;
                              }),
                          my.FormItem(
                              label: '',
                              name: 'isRememb',
                              width: size.width / 2,
                              dicData: const [
                                {'value': true, 'label': '记住密码'}
                              ],
                              border: InputBorder.none,
                              type: my.WInputType.checkbox,
                              valueTransformer: (value) {
                                return value is List
                                    ? value.isNotEmpty
                                        ? value[0]
                                        : false
                                    : value;
                              }),
                        ],
                        if (!_isLoginForm) ...[
                          my.FormItem(
                              key: const ValueKey('serverIp'),
                              label: '服务器地址',
                              name: 'serverIp',
                              width: size.width / 2,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '请输入服务器地址';
                                }
                                return null;
                              }),
                          my.FormItem(
                              key: const ValueKey('port'),
                              label: '端口号',
                              name: 'port',
                              width: size.width / 2,
                              type: my.WInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '请输入端口号';
                                }
                                return null;
                              }),
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
                          // my.FormItem(
                          //     label: '日期',
                          //     name: 'date',
                          //     width: size.width / 2,
                          //     type: my.WInputType.date,
                          //     readOnly: true,
                          //     onTap: () {
                          //       _showDateTimePicker(DateTimePickerMode.date);
                          //     })
                        ],
                        Padding(
                            padding: const EdgeInsets.all(30),
                            child: CustomBtn(
                                size: const Size(420, 80),
                                child: Text(_isLoginForm ? '提交' : '保存',
                                    style: TextStyle(
                                        fontSize: 28.sp, color: Colors.white)),
                                onPressed: () => loginSubmit()))
                      ])))
        ]));
  }
}
