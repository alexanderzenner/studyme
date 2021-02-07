import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final bool isSubtitle;
  final IconButton action;

  SectionTitle(this.text, {this.isSubtitle = false, this.action});

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
                      fontWeight: this.isSubtitle ? null : FontWeight.bold,
                      fontSize: 18,
                      color: this.isSubtitle
                          ? null
                          : Theme.of(context).primaryColor)),
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
