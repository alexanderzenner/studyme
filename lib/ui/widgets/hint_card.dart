import 'package:flutter/material.dart';

class HintCard extends StatelessWidget {
  final String titleText;
  final String bodyText;

  HintCard({this.titleText, this.bodyText});

  @override
  Widget build(BuildContext context) {
    Widget title = titleText != null
        ? Text(titleText, style: TextStyle(fontWeight: FontWeight.bold))
        : null;
    Widget body = bodyText != null ? Text(bodyText) : null;
    return Card(
      color: Colors.blue[50],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.blue,
            size: 32,
          ),
          title: title,
        ),
        if (body != null)
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: body)
      ]),
    );
  }
}
