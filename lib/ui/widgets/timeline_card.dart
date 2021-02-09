import 'package:flutter/material.dart';

class TimelineCard extends StatelessWidget {
  final bool isActive;
  final Widget cardChild;
  final Color cardColor;
  final Widget belowCardChild;

  TimelineCard(
      {this.isActive = false,
      this.cardChild,
      this.cardColor,
      this.belowCardChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Column(children: [
        Container(
            height: 50,
            child: Card(
                shape: isActive
                    ? RoundedRectangleBorder(
                        side: new BorderSide(
                            color: Theme.of(context).primaryColor, width: 4.0),
                        borderRadius: BorderRadius.circular(4.0))
                    : null,
                color: cardColor,
                child: Center(child: cardChild))),
        if (belowCardChild != null) belowCardChild
      ]),
    );
  }
}
