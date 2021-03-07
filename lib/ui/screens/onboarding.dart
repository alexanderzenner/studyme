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
  final int _numPages = 5;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool _acceptedTerms = false;
  bool _acceptedPrivacy = false;

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
        padding: EdgeInsets.symmetric(vertical: 20.0),
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
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(children: [
                      Text("Welcome to StudyMe",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                              color: Colors.green)),
                      SizedBox(height: 10),
                      Text(
                          "Have you ever tried something to improve your health or wellbeing but weren't sure if it worked?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).primaryColor)),
                      SizedBox(height: 10),
                      Text(
                          "Or maybe you tried multiple things and didn’t know which worked better?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Theme.of(context).primaryColor)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(
                      children: <Widget>[
                        Text(
                            "With StudyMe, you can run your own experiments to gather real evidence about whether something you do is helping you achieve your health goals.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Text(
                            "There are 3 main steps to create your experiment:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        SizedBox(height: 10),
                        Text("1. Set a goal ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        SizedBox(height: 5),
                        Text("Example: Lose weight",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 23,
                                color: Theme.of(context).primaryColor)),
                        SizedBox(height: 10),
                        Text(
                            "2. Pick something you want to try out to achieve that goal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        SizedBox(height: 5),
                        Text("Example: Run for half an hour every two days",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 23,
                                color: Theme.of(context).primaryColor)),
                        SizedBox(height: 10),
                        Text(
                            "2. Choose the type of data you want to collect, to see if you are achieving your goal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor)),
                        SizedBox(height: 5),
                        Text("Example: Weight (kg)",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 23,
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: ListView(
                      children: <Widget>[
                        Text(
                            "Using this information, StudyMe will help you set up an experiment that keeps you on schedule and organizes your data based on scientific methods.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Theme.of(context).primaryColor))
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: ListView(
                        children: [
                          Text("Ready? Let's get started!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                  color: Theme.of(context).primaryColor)),
                          SizedBox(height: 40),
                          Column(
                            children: [
                              OutlinedButton.icon(
                                icon: Icon(Icons.assignment_outlined),
                                label: Text('Terms of Use'),
                                onPressed: _showTerms,
                              ),
                              SwitchListTile(
                                title: Text(
                                    "I have read and agree to the terms of use"),
                                value: _acceptedTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _acceptedTerms = value;
                                  });
                                },
                              ),
                              SizedBox(height: 20),
                              OutlinedButton.icon(
                                icon: Icon(Icons.privacy_tip_outlined),
                                label: Text('Privacy Policy'),
                                onPressed: _showPrivacy,
                              ),
                              SwitchListTile(
                                title: Text(
                                    "I have read and agree to the privacy policy"),
                                value: _acceptedPrivacy,
                                onChanged: (value) {
                                  setState(() {
                                    _acceptedPrivacy = value;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: _currentPage > 0 ? 1 : 0,
                  child: RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        _acceptedTerms = false;
                        _acceptedPrivacy = false;
                      });
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    elevation: 2.0,
                    fillColor: Colors.blueGrey,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator()),
                Opacity(
                  opacity: _isAtEnd() && !(_acceptedTerms && _acceptedPrivacy)
                      ? 0
                      : 1,
                  child: RawMaterialButton(
                    onPressed: () {
                      if (_isAtEnd()) {
                        if (_acceptedTerms && _acceptedPrivacy) {
                          _navigateToCreator();
                        } else {
                          return null;
                        }
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    elevation: 2.0,
                    fillColor: _isAtEnd() ? Colors.green : Colors.blueGrey,
                    child: Icon(_isAtEnd() ? Icons.check : Icons.arrow_forward,
                        color: Colors.white),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _isAtEnd() {
    return _currentPage == _numPages - 1;
  }

  _navigateToCreator() {
    Provider.of<AppData>(context, listen: false)
        .addStepLogForSurvey('complete onboarding');
    Provider.of<AppData>(context, listen: false)
        .saveAppState(AppState.CREATING_DETAILS);
    Navigator.pushReplacementNamed(context, Routes.creator);
  }

  _showTerms() {
    _showDialog(Text("Terms of Use"), [
      Text(
          'The StudyMe app (in the following refered to as "StudyMe") is a research prototype and is used to research what experiments people are interested in and what type of assistance they require in setting up an experiment.'),
      Text(''),
      Text(
          'StudyMe does not provide medical advice. Any suggestion made by StudyMe have to be thoroughly reviewed by you and your doctor. Consult the experiments you want to conduct with your doctor before starting them. If you have any doubts or concerns now or in future, contact and seek advice from your doctor.'),
      Text(''),
      Text(
          'All responsibility and liability for the experiments created in StudyMe lies with you, the user of StudyMe. The creators of StudyMe are not liable for any misuse or harm caused to you or others while using StudyMe.'),
      Text(''),
      Text(
          'The creators of StudyMe reserve the right to change functionalities of StudyMe at any time.'),
      Text(''),
      Text('You have to be 18 years or older in order to use StudyMe.')
    ]);
  }

  _showPrivacy() {
    _showDialog(Text("Privacy Policy"), [
      Text(
          'All experiments and data created or added inside the StudyMe app (in the following referred to as "StudyMe") are stored on device only.'),
      Text(''),
      Text(
          'The creators of StudyMe usually (see exception 1 below) do not have any access to your data and can not see who you are or when and how you use the app.'),
      Text(''),
      Text('*Optional* Exception 1: Sharing created experiments through survey',
          style: TextStyle(fontWeight: FontWeight.bold)),
      Text(
          'If you are using the app as part of one of the surveys related to the research behind StudyMe, you may be asked to share your created experiments or data.'),
      Text(
          'In this case you copy the data manually and paste it into the respective survey.'),
      Text(
          'When doing so, you agree to the terms of the respective survey on how your data is handled.'),
      Text(
          'If you decide to share your data with any other party, the creators of StudyMe are not responsible for any harm or misuse that might incur.'),
      Text(
          'The shared data includes any information you entered when setting up an experiment together with timestamps on when you completed different steps within the app.'),
      Text(
          'The shared data does not include any personally identifiable information, as the app does not ask for it, unless you enter such information on purpose in one of the fields.'),
      Text(''),
      Text(
          '*Optional* Exception 2: Integrating with Apple Health or Google Fit third-party apps',
          style: TextStyle(fontWeight: FontWeight.bold)),
      Text(
          'StudyMe gives you the option to automatically read data from third-party apps provided by Apple Inc. or Google LLC. When you use these apps you agree to their privacy policies independently to StudyMe.'),
      Text(
          'When you decide to automatically read data from one of these apps, their providers are able to collect information on when you use StudyMe and what data is read by StudyMe. However, StudyMe does not write back any data, so any data you add inside StudyMe is saved inside StudyMe only.'),
    ]);
  }

  _showDialog(Widget title, List<Widget> content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: title,
                content: Container(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: content,
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close")),
                ]));
  }
}
