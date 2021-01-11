import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/editor/measure_editor_screen.dart';
import 'package:studyme/widgets/choice_measure_widget.dart';
import 'package:studyme/widgets/free_measure_widget.dart';
import 'package:studyme/widgets/scale_measure_widget.dart';

class MeasurePreviewScreen extends StatefulWidget {
  final Measure measure;
  final bool isAdded;

  const MeasurePreviewScreen({@required this.measure, @required this.isAdded});

  @override
  _MeasurePreviewScreenState createState() => _MeasurePreviewScreenState();
}

class _MeasurePreviewScreenState extends State<MeasurePreviewScreen> {
  Measure _measure;

  @override
  initState() {
    _measure = widget.measure.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("Preview Measure"),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            if (_measure.isDefault) Text("(Default Measure)"),
            Card(child: _buildPreviewView()),
            if (!widget.isAdded)
              OutlineButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Add to trial"),
                  onPressed: () {
                    Navigator.pop(context, _measure);
                  }),
            if (!_measure.isDefault)
              OutlineButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
                  onPressed: () {
                    _editMeasure(context);
                  })
          ],
        ));
  }

  _buildPreviewView() {
    Widget _preview;
    switch (_measure.runtimeType) {
      case FreeMeasure:
        _preview = FreeMeasureWidget(_measure, null);
        break;
      case ChoiceMeasure:
        _preview = ChoiceMeasureWidget(_measure, null);
        break;
      case ScaleMeasure:
        _preview = ScaleMeasureWidget(_measure, null);
        break;
      default:
        return null;
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        if (_measure.name != null && _measure.name.length > 0)
          Text(_measure.name),
        if (_measure.description != null && _measure.description.length > 0)
          Text(_measure.description),
        if (_preview != null) _preview,
      ]),
    );
  }

  _editMeasure(context) {
    _navigateToEditor(context).then((result) {
      if (result != null) {
        Provider.of<AppState>(context, listen: false)
            .updateMeasure(widget.measure, result);
        Navigator.pop(context);
      }
    });
  }

  Future _navigateToEditor(context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MeasureEditorScreen(isCreator: false, measure: _measure),
      ),
    );
  }
}
