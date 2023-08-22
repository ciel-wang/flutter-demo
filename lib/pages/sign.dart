import 'package:flutter/material.dart';
import '../components/customBackground.dart';
import '../components/head.dart';
import '../components/formItem.dart';
import '../components/customBtn.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  String imgUrl = "";
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Column(children: [
      const HeadComponent(),
      Expanded(
          child: Card(
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              shadowColor: const Color.fromRGBO(0, 28, 138, 0.18),
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(children: [
                                Row(children: [
                                  const Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        ListTile(
                                            title: Text('来访人信息',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                        SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('姓        名'),
                                                textColor: Color.fromRGBO(
                                                    30, 31, 33, 1),
                                                title: Text("张三",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1))),
                                        SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('民        族'),
                                                title: Text("民族",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold)))),
                                        SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('证件类型'),
                                                title: Text("证件类型",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold)))),
                                        SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('证件编号'),
                                                title: Text("证件编号",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1))),
                                        SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('签发单位'),
                                                title: Text("签发单位",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1))),
                                        SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('地        址'),
                                                title: Text("地址",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1)))
                                      ])),
                                  Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  30, 31, 33, 0.3))),
                                      child: imgUrl.isEmpty
                                          ? const Icon(
                                              IconData(0xe670,
                                                  fontFamily: 'iconfont'),
                                              size: 200,
                                              color: Color.fromRGBO(
                                                  30, 31, 33, 0.2))
                                          : Image.network(imgUrl,
                                              fit: BoxFit.cover))
                                ]),
                                const SizedBox(height: 30),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FormItem(
                                                  label: '手机号码',
                                                  size: InputSize.mini,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return '请输入手机号码';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                FormItem(
                                                    label: '携带物品',
                                                    size: InputSize.mini),
                                                FormItem(
                                                    label: '车牌号',
                                                    size: InputSize.mini),
                                                FormItem(
                                                  label: '来访人数',
                                                  size: InputSize.mini,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return '请输入来访人数';
                                                    }
                                                    return null;
                                                  },
                                                )
                                              ])),
                                      Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      30, 31, 33, 0.3))),
                                          child: imgUrl.isEmpty
                                              ? const Icon(
                                                  IconData(0xe670,
                                                      fontFamily: 'iconfont'),
                                                  size: 200,
                                                  color: Color.fromRGBO(
                                                      30, 31, 33, 0.2))
                                              : Image.network(imgUrl,
                                                  fit: BoxFit.cover))
                                    ])
                              ]))),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  padding: const EdgeInsets.only(left: 20),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: Color.fromRGBO(
                                                  30, 31, 33, 0.3)))),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const ListTile(
                                            title: Text('其他',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 15, 0, 0),
                                            child: FormItem(
                                                label: '来访公司',
                                                size: InputSize.mini,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return '请输入来访公司';
                                                  }
                                                  return null;
                                                })),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: FormItem(
                                                label: '来源地',
                                                size: InputSize.mini,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return '请输入来源地';
                                                  }
                                                  return null;
                                                })),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: FormItem(
                                                label: '访问事由',
                                                size: InputSize.mini,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return '请输入访问事由';
                                                  }
                                                  return null;
                                                })),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: FormItem(
                                                label: '访问线路',
                                                size: InputSize.mini,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return '请输入访问线路';
                                                  }
                                                  return null;
                                                })),
                                        const ListTile(
                                            title: Text('被访人信息',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20))),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 15),
                                            child: FormItem(
                                                label: '手机号',
                                                size: InputSize.mini,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return '请输入手机号';
                                                  }
                                                  return null;
                                                })),
                                        const SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('姓        名'),
                                                textColor: Color.fromRGBO(
                                                    30, 31, 33, 1),
                                                title: Text("张三",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1))),
                                        const SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('公        司'),
                                                textColor: Color.fromRGBO(
                                                    30, 31, 33, 1),
                                                title: Text("张三",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1))),
                                        const SizedBox(
                                            height: 40,
                                            child: ListTile(
                                                leading: Text('部        门'),
                                                textColor: Color.fromRGBO(
                                                    30, 31, 33, 1),
                                                title: Text(
                                                    "张三fdfjds;flgkl;gdjfgdjfgkjfdlgdgoregkldorgsgmldfgoepmhgsgodropgldsgldmdpsfdlhmlsdmhdsgo'pelgdfgdjgdjgfdgdlgfdlkgmkdgdgkdjgdfgmdkgdgjlkml",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 0, 0, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1)))
                                      ]))))
                    ],
                  )))),
      SizedBox(
          height: 80,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            CustomBtn(
              child: const Text('primary',
                  style: TextStyle(fontSize: 28, color: Colors.white)),
              onPressed: () {},
            ),
            CustomBtn(
              type: ColorType.warning,
              onPressed: () {},
              child: const Text('warning',
                  style: TextStyle(fontSize: 28, color: Colors.white)),
            ),
            CustomBtn(
              type: ColorType.info,
              onPressed: () {},
              child: const Text('info',
                  style: TextStyle(
                      fontSize: 28, color: Color.fromRGBO(106, 176, 254, 1))),
            )
          ]))
    ]));
  }
}
