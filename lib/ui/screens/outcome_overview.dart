import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/outcome.dart';
import 'package:studyme/ui/screens/outcome_editor.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';

class OutcomeOverview extends StatefulWidget {
  final bool isPreview;
  final Outcome outcome;
  final Function() onSave;

  const OutcomeOverview({this.isPreview, this.outcome, this.onSave});

  @override
  _OutcomeOverviewState createState() => _OutcomeOverviewState();
}

class _OutcomeOverviewState extends State<OutcomeOverview> {
  bool _isDeleting;

  @override
  void initState() {
    _isDeleting = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(widget.outcome.outcome),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                EditableListTile(
                    title: Text("Goal"),
                    subtitle: Text(widget.outcome.outcome),
                    canEdit: !widget.isPreview,
                    onTap: _editOutcome),
                ButtonBar(
                  children: [
                    if (widget.isPreview)
                      OutlinedButton.icon(
                          icon: Icon(Icons.add),
                          label: Text("Select"),
                          onPressed: () {
                            _addOutcome();
                          }),
                    if (!widget.isPreview)
                      OutlinedButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text("Remove"),
                          onPressed: _remove),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addOutcome() {
    _getSetter()(widget.outcome);
    Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
  }

  _editOutcome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutcomeEditor(
            outcome: widget.outcome,
            onSave: (Outcome _outcome) {
              _getSetter()(_outcome);
              Navigator.pop(context);
            }),
      ),
    );
  }

  _remove() {
    setState(() {
      _isDeleting = true;
    });
    _getSetter()(null);
    Navigator.pop(context);
  }

  _getSetter() {
    return Provider.of<AppData>(context, listen: false).setOutcome;
  }
}
