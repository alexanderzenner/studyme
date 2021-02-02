import 'package:flutter/material.dart';

class HintCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.blueGrey,
          child: Column(children: [
            ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: Text("Add Intervention A",
                    style: TextStyle(color: Colors.white)),
                trailing:
                    Text("Step 1/5", style: TextStyle(color: Colors.white))),
            Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    Text(
                        "Add the first intervention (Intervention A) that you want to compare by clicking on the plus.",
                        style: TextStyle(color: Colors.white))
                  ],
                ))
          ]),
        ),
        SizedBox(height: 20)
      ],
    );
  }
}
