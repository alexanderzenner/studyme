import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/intervention/intervention.dart';

class InterventionEditor extends StatefulWidget {
  final Intervention intervention;

  const InterventionEditor({@required this.intervention});

  @override
  _InterventionEditorState createState() => _InterventionEditorState();
}

class _InterventionEditorState extends State<InterventionEditor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.intervention.name,
            onChanged: (text) {
              widget.intervention.name = text;
            },
            decoration: InputDecoration(hintText: 'Name'),
          ),
          TextFormField(
            initialValue: widget.intervention.description,
            onChanged: (text) {
              widget.intervention.description = text;
            },
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(hintText: 'Description'),
          ),
        ],
      ),
    );
  }
}
