import 'package:flutter/material.dart';

class HintCard extends StatelessWidget {
  final String trailing;
  final String title;
  final Widget body;

  HintCard({this.title, this.trailing, this.body});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Column(children: [
        ListTile(
          leading: Icon(
            Icons.info,
            color: Colors.white,
          ),
          title: title != null
              ? Text(title, style: TextStyle(color: Colors.white))
              : null,
          trailing: trailing != null
              ? Text(trailing, style: TextStyle(color: Colors.white))
              : null,
        ),
        if (body != null) body
      ]),
    );
  }
}
