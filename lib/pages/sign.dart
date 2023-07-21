import 'package:flutter/material.dart';

class Sign extends StatelessWidget {
  Sign({super.key});
  final List<Map> list = [
    {'value': '1', 'label': '选项一'},
    {'value': '2', 'label': '选项二'},
    {'value': '3', 'label': '选项三'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: 300,
          height: 300,
          color: Colors.amberAccent,
          child: Form(
              child: Column(
            children: [
              DropdownButtonFormField(
                elevation: 0,
                decoration: const InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder()),
                items: list.map((map) {
                  return DropdownMenuItem(
                    value: map['value'],
                    child: Text(map['label']),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ],
          )),
        )
      ],
    ));
  }
}
