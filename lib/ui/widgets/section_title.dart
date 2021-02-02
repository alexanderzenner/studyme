import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final IconButton action;

  SectionTitle(this.text, {this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor)),
            ],
          ),
          if (action != null)
            Row(
              children: [action],
            )
        ],
      ),
    );
  }
}
