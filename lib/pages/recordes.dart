import 'package:flutter/material.dart';
import '../components/custom_background.dart';
import '../components/head.dart';
import '../components/custom_search.dart';
import '../components/dottedline_painter.dart';
import '../components/custom_btn.dart';

class RecordesPage extends StatefulWidget {
  const RecordesPage({super.key});

  @override
  State<RecordesPage> createState() => _RecordesPageState();
}

class _RecordesPageState extends State<RecordesPage> {
  List<Map<String, dynamic>> cardList = [
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    },
    {
      'name': '张三',
      'phone': '15723232323',
      'starttime': '2023-08-11 11:00:00',
      'endTime': '2023-08-11 18:00:00'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Column(children: [
      const HeadComponent(),
      const CustomSearch(hintText: '请输入访客姓名或电话'),
      const SizedBox(height: 20),
      Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.2),
              itemCount: cardList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Stack(children: [
                  const Positioned(top: 8, right: 8, child: Icon(Icons.star)),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${cardList[index]['name']}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis)),
                            const SizedBox(height: 14),
                            Text('${cardList[index]['phone']}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis)),
                            const SizedBox(height: 20),
                            Row(children: [
                              SizedBox(
                                  width: 90,
                                  child: Column(children: [
                                    Text(
                                        '${cardList[index]['starttime'].substring(11, 16)}'),
                                    const Text('到访')
                                  ])),
                              const Expanded(
                                  child: DottedLinePainter(
                                      axis: Axis.horizontal,
                                      dashedHeight: 1,
                                      dashedWidth: 6,
                                      count: 12,
                                      color: Color.fromRGBO(128, 128, 128, 1))),
                              SizedBox(
                                  width: 90,
                                  child: Column(children: [
                                    Text(
                                        '${cardList[index]['endTime'].substring(11, 16)}'),
                                    const Text('签离')
                                  ]))
                            ])
                          ]))
                ]));
              })),
      CustomBtn(
          size: const Size(300, 80),
          onPressed: () {},
          child: const Text('返回首页',
              style: TextStyle(fontSize: 28, color: Colors.white)))
    ]));
  }
}
