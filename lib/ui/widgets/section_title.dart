import 'package:flutter/material.dart';
import 'package:studyme/ui/widgets/title_text.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final IconButton action;

  SectionTitle(this.text, {this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TitleText(text),
              ],
            ),
            if (action != null)
              Row(
                children: [action],
              )
          ],
        ),
      ],
    );
  }
}
