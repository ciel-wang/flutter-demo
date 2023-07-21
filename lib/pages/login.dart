import 'package:flutter/material.dart';
import '../components/customBackground.dart';
import '../components/head.dart';
import '../components/formItem.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final List<Map> list = [
    {'value': '1', 'label': '选项一'},
    {'value': '2', 'label': '选项二'},
    {'value': '3', 'label': '选项三'}
  ];

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    return CustomBackground(
        child: Column(
      children: [
        const HeadComponent(),
        const Padding(padding: EdgeInsets.only(top: 100)),
        Container(
          width: size.width / 2,
          color: Colors.amber,
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
                      validator2: (value) {
                        if (value == null) return '请选择';
                        return null;
                      },
                      onChanged: (value) {
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Navigator.pushNamed(context, '/sign');
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
