import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Welcome. \nLet\'s start your journey to better health and well-being. \nI am your companion and will help you find the best path for you.',
                  style: TextStyle(fontSize: 40)),
              SizedBox(
                height: 40,
              ),
              OutlineButton(
                child: Text('Sounds good', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
