import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';

import '../../routes.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Welcome to StudyMe",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                            "Have you ever tried something to improve your health or wellbeing but weren't sure whether it worked?",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 10),
                        Text(
                            "Or maybe you tried multiple things and didn’t know which worked better?",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 10),
                        Text(
                            "With StudyMe, you can run your own experiments to gather real evidence about whether something you do is helping you achieve your health goals.",
                            style: TextStyle(fontSize: 23)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "There are 3 main steps to create your experiment:",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 10),
                        Text("1. Set a goal ", style: TextStyle(fontSize: 23)),
                        SizedBox(height: 5),
                        Text("Example: Lose weight",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 23)),
                        SizedBox(height: 10),
                        Text(
                            "2. Pick something you want to try out to achieve that goal",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 5),
                        Text("Example: Run for half an hour every two days",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 23)),
                        SizedBox(height: 10),
                        Text(
                            "2. Choose the type of data you want to collect, to see if you are achieving your goal",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 5),
                        Text("Example: Weight (kg)",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 23)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "Using this information, StudyMe will help you set up an experiment that keeps you on schedule and organizes your data based on scientific methods.",
                            style: TextStyle(fontSize: 23))
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Ready? Let's get started!",
                              style: TextStyle(fontSize: 23))
                        ],
                      ))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_isAtEnd()) {
            _navigateToCreator();
          } else {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        },
        backgroundColor: _isAtEnd() ? Colors.green : Colors.blueGrey,
        child: Icon(_isAtEnd() ? Icons.check : Icons.arrow_forward),
      ),
    );
  }

  _isAtEnd() {
    return _currentPage == _numPages - 1;
  }

  _navigateToCreator() {
    Provider.of<AppData>(context, listen: false)
        .saveAppState(AppState.CREATING_DETAILS);
    Navigator.pushNamed(context, Routes.creator);
  }
}
