import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, model, child) {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.logs.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(DateFormat('yyyy-MM-dd')
                        .format(model.logs[index].dateTime)),
                    Text(model.logs[index].value.toString()),
                  ],
                );
              }));
    });
  }
}
