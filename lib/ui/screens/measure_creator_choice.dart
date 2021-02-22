import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/creator_schedule.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/choice_editor.dart';
import 'package:studyme/ui/widgets/section_title.dart';

class MeasureCreatorChoice extends StatefulWidget {
  final String title;
  final ChoiceMeasure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureCreatorChoice(
      {@required this.title,
      @required this.measure,
      @required this.onSave,
      @required this.save});

  @override
  _MeasureCreatorChoiceState createState() => _MeasureCreatorChoiceState();
}

class _MeasureCreatorChoiceState extends State<MeasureCreatorChoice> {
  List<Choice> _choices;

  @override
  void initState() {
    _choices = widget.measure.choices.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title),
              Visibility(
                visible: true,
                child: Text(
                  'Choices',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: widget.save ? Icons.check : Icons.arrow_forward,
                canPress: _canSubmit(),
                onPressed: _submit)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SectionTitle("Choices",
                    isSubtitle: true,
                    action: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => setState(() {
                              _choices.add(Choice());
                            }))),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _choices.length,
                    itemBuilder: (content, index) {
                      return ChoiceEditor(
                          key: UniqueKey(),
                          choice: _choices[index],
                          index: index,
                          remove: () => setState(() {
                                _choices.removeAt(index);
                              }));
                    }),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _choices.length > 0;
  }

  _submit() {
    widget.measure.choices = _choices;
    widget.save
        ? widget.onSave(widget.measure)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatorSchedule(
                  title: widget.title,
                  objectWithSchedule: widget.measure,
                  onSave: widget.onSave),
            ));
  }
}
