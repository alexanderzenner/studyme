import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice.dart';

class ChoiceEditorScreen extends StatefulWidget {
  final Choice choice;
  final int index;
  final void Function() remove;

  ChoiceEditorScreen({@required this.choice, @required this.index, @required this.remove, Key key}) : super(key: key);

  @override
  _ChoiceEditorScreenState createState() => _ChoiceEditorScreenState();
}

class _ChoiceEditorScreenState extends State<ChoiceEditorScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(flex: 1, child: Text('${widget.index + 1}.')),
      Expanded(
        flex: 16,
        child: TextFormField(
            initialValue: widget.choice.value,
            onChanged: (text) => setState(() {
                  widget.choice.value = text;
                })),
      ),
      Expanded(
        flex: 3,
        child: OutlineButton(child: Text('Delete'), onPressed: widget.remove),
      )
    ]);
  }
}
