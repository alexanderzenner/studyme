import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice.dart';

class ChoiceEditor extends StatefulWidget {
  final Choice choice;
  final int index;
  final void Function() remove;

  ChoiceEditor(
      {@required this.choice,
      @required this.index,
      @required this.remove,
      Key key})
      : super(key: key);

  @override
  _ChoiceEditorState createState() => _ChoiceEditorState();
}

class _ChoiceEditorState extends State<ChoiceEditor> {
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
        child: FlatButton(child: Icon(Icons.delete), onPressed: widget.remove),
      )
    ]);
  }
}
