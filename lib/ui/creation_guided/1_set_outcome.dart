import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';

class SetOutcomePage extends StatefulWidget {
  @override
  _SetOutcomePageState createState() => _SetOutcomePageState();
}

class _SetOutcomePageState extends State<SetOutcomePage> {
  final outcomeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    outcomeController.dispose();
    super.dispose();
  }

  void setOutcomeAndGoToNextPage() {
    Provider.of<AppState>(context, listen: false).setOutcome(outcomeController.text);
    Navigator.pushNamed(context, '/2_set_start');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set a goal"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text('What do you want to improve about your health or well-being?', style: TextStyle(fontSize: 40)),
              SizedBox(height: 20),
              TextField(
                controller: outcomeController,
                decoration: InputDecoration(hintText: 'I want to...'),
              ),
              SizedBox(height: 20),
              OutlineButton(
                child: Text('Done', style: TextStyle(fontSize: 20)),
                onPressed: setOutcomeAndGoToNextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
