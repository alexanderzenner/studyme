import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/free_measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';
import 'package:studyme/ui/widgets/timeline_card.dart';

import '../../routes.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numPages = 5;
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
                        Divider(height: 40),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 23),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Are you trying to reach a ',
                              ),
                              TextSpan(
                                  text: 'goal',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text:
                                    " you have for your health or wellbeing, but you are unsure which of the things you could do to achieve it is best for you?",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 23),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Running a ',
                              ),
                              TextSpan(
                                  text: 'trial',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                text:
                                    " can bring certainty and with StudyMe you can create and run your own personal health trials.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InterventionLetter('a'),
                            Text("vs.", style: TextStyle(fontSize: 20)),
                            InterventionLetter('b')
                          ],
                        ),
                        Divider(height: 40),
                        Text(
                            "The idea of a trial is to compare two things labeled as A and B.",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 23),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'We call the things you compare ',
                              ),
                              TextSpan(
                                  text: 'interventions.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "An intervention can be anything that is aimed at reaching your goal, from doing a certain type of workout to taking a specific supplement.",
                            style: TextStyle(fontSize: 23)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TimelineCard(cardChild: InterventionLetter('a')),
                            TimelineCard(cardChild: InterventionLetter('b')),
                            TimelineCard(cardChild: InterventionLetter('b')),
                            TimelineCard(cardChild: InterventionLetter('a')),
                            TimelineCard(cardChild: InterventionLetter('a')),
                            TimelineCard(cardChild: InterventionLetter('b')),
                          ],
                        ),
                        Divider(height: 40),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 23),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'During a trial you complete multiple ',
                              ),
                              TextSpan(
                                  text: 'phases.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("During each phase you follow either A or B.",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 10),
                        Text(
                            "The more phases you complete, and the longer they are, the more certain you can be about the result.",
                            style: TextStyle(fontSize: 23)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TimelineCard(cardChild: Icon(FreeMeasure.icon)),
                            TimelineCard(cardChild: Icon(ChoiceMeasure.icon)),
                            TimelineCard(cardChild: Icon(ScaleMeasure.icon)),
                            TimelineCard(cardChild: Icon(SyncedMeasure.icon)),
                          ],
                        ),
                        Divider(height: 40),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 23),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'To know whether A or B is actually helping you, we use ',
                              ),
                              TextSpan(
                                  text: 'measures.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "A measure ideally is linked to the goal you are trying to achieve.",
                            style: TextStyle(fontSize: 23)),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 23),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'For example if you want to improve your sleep, one measure could be ',
                              ),
                              TextSpan(
                                  text: 'hours slept last night.',
                                  style:
                                      TextStyle(fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
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
        .saveAppState(AppState.CREATING);
    Navigator.pushReplacementNamed(context, Routes.creator);
  }
}
