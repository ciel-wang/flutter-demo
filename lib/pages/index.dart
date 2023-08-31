import 'package:flutter/material.dart';
import '../components/custom_background.dart';
import '../components/head.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          const HeadComponent(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/sign'),
                child: const SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconData(0xe679, fontFamily: 'iconfont'),
                                  size: 58, color: Colors.blue),
                              Padding(padding: EdgeInsets.all(10)),
                              Text('访客登记',
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.black))
                            ])))),
            const Padding(padding: EdgeInsets.all(20)),
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/sign'),
                child: const SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconData(0xe89b, fontFamily: 'iconfont'),
                                  size: 58, color: Colors.blue),
                              Padding(padding: EdgeInsets.all(10)),
                              Text('来访记录',
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.black))
                            ]))))
          ]),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('今日访客到访汇总',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const Divider(),
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(247, 250, 255, 1),
                                  Color.fromRGBO(245, 249, 255, 0.22),
                                  Color.fromRGBO(247, 250, 255, 1)
                                ], // 渐变色的颜色列表
                                begin: Alignment.topLeft, // 渐变的起点
                                end: Alignment.bottomRight // 渐变的终点
                                ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(children: [
                                Icon(IconData(0xe65e, fontFamily: 'iconfont'),
                                    size: 32, color: Colors.blue),
                                Padding(padding: EdgeInsets.all(5)),
                                Text('17',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold)),
                                Padding(padding: EdgeInsets.all(5)),
                                Text('来访人数', style: TextStyle(fontSize: 18))
                              ]),
                              Column(children: [
                                Icon(IconData(0xe65d, fontFamily: 'iconfont'),
                                    size: 32, color: Colors.blue),
                                Padding(padding: EdgeInsets.all(5)),
                                Text('17',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold)),
                                Padding(padding: EdgeInsets.all(5)),
                                Text('访问中人数', style: TextStyle(fontSize: 18))
                              ]),
                              Column(children: [
                                Icon(IconData(0xe65c, fontFamily: 'iconfont'),
                                    size: 32, color: Colors.blue),
                                Padding(padding: EdgeInsets.all(5)),
                                Text('17',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold)),
                                Padding(padding: EdgeInsets.all(5)),
                                Text('签离人数', style: TextStyle(fontSize: 18))
                              ])
                            ]))
                  ]))
        ]));
  }
}
