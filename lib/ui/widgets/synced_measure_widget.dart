import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:studyme/models/measure/synced_measure.dart';

class SyncedMeasureWidget extends StatelessWidget {
  final SyncedMeasure measure;

  final void Function(num value) updateValue;

  SyncedMeasureWidget({this.measure, this.updateValue});

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return FutureBuilder<Widget>(
        future: _loadData(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<Widget> _loadData() async {
    List<HealthDataPoint> data = await measure.getValue();
    if (data.length > 0) {
      num value = data[0].value;
      updateValue(value);
      return Column(
        children: [
          Text("Value loaded"),
          TextFormField(
            initialValue: value.toString(),
            keyboardType: TextInputType.number,
            readOnly: true,
          ),
        ],
      );
    } else {
      Column(
        children: [
          Text("Value couldn't be loaded, please enter it manually"),
        ],
      );
    }
  }
}
