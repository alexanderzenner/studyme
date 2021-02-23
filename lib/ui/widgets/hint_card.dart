import 'package:flutter/material.dart';

class HintCard extends StatelessWidget {
  final String titleText;
  final List<Widget> body;
  final bool canClose;

  HintCard({this.titleText, this.body, this.canClose = false});

  @override
  Widget build(BuildContext context) {
    Widget title = titleText != null
        ? Text(titleText, style: TextStyle(fontWeight: FontWeight.bold))
        : null;
    return Card(
      color: Colors.blue[50],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.blue,
            size: 32,
          ),
          trailing: canClose
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                  ),
                  onPressed: () => print("hi"))
              : null,
          title: title,
        ),
        if (body != null)
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: body))
      ]),
    );
  }
}
