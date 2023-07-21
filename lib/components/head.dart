import 'package:flutter/material.dart';

class HeadComponent extends StatefulWidget {
  const HeadComponent({super.key});

  @override
  State<HeadComponent> createState() => _HeadComponentState();
}

class _HeadComponentState extends State<HeadComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            'static/img/logo.png',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'AIoT访客管理系统',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        )
      ],
    );
  }
}
