import 'package:flutter/material.dart';

class LibraryCreateButton extends StatelessWidget {
  final Function() onPressed;

  LibraryCreateButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.green,
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'Create your own',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: onPressed),
          Text('or select existing:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
