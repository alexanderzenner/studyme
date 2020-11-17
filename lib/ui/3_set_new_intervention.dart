import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';

class SetStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("Choose a path"),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text('What do you want to try to "${model.trial.outcome}"?', style: TextStyle(fontSize: 40)),
                      SizedBox(height: 20),
                      OutlineButton(
                          child: Text('Nothing really.\nI am starting my journey', style: TextStyle(fontSize: 20)))
                    ],
                  ),
                ),
              ),
            ));
  }
}
