import 'package:flutter/material.dart';

class CustomSearch extends StatefulWidget {
  final String? hintText;
  final double height;
  final double fontSize;
  const CustomSearch(
      {Key? key, this.hintText, this.height = 50, this.fontSize = 16})
      : super(key: key);

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 600,
        height: widget.height,
        child: IntrinsicHeight(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(top: 0.5),
                    child: TextField(
                        style: TextStyle(fontSize: widget.fontSize),
                        decoration: InputDecoration(
                            hintText: widget.hintText,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.only(
                                top: (widget.height - widget.fontSize) / 2,
                                bottom: (widget.height - widget.fontSize) / 2,
                                left: 20,
                                right: 20),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))))))),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(0),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.only(left: 20, right: 20)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))))),
              child: const Icon(Icons.search),
            )
          ],
        )));
  }
}
