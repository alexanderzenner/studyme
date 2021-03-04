import 'package:flutter/material.dart';
import 'package:studyme/ui/widgets/hightlighted_action_button.dart';

class LibraryCreateButton extends StatelessWidget {
  final Function() onPressed;

  LibraryCreateButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          HighlightedActionButton(
              icon: Icons.add,
              labelText: 'Create your own',
              onPressed: onPressed),
          Text('or select existing:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
