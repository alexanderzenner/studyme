import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/outcome.dart';
import 'package:studyme/ui/screens/outcome_editor.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';

class OutcomeOverview extends StatefulWidget {
  const OutcomeOverview();

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
    return _isDeleting
        ? Text('')
        : Consumer<AppData>(builder: (context, model, child) {
            Outcome outcome = model.trial.outcome;
            return Scaffold(
                appBar: AppBar(
                  brightness: Brightness.dark,
                  title: Text(outcome.outcome),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        EditableListTile(
                            title: Text("Goal"),
                            subtitle: Text(outcome.outcome),
                            canEdit: true,
                            onTap: () => _editOutcome(outcome)),
                        ButtonBar(
                          children: [
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
          });
  }

  _editOutcome(Outcome outcome) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutcomeEditor(
            outcome: outcome,
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
