import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:timeline_tile/timeline_tile.dart';

class JourneyOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _trial = Provider.of<AppState>(context, listen: false).trial;
    final _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Journey Overview')),
      body: Center(
        child: Column(
          children: [
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.4,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                indicator: IconIndicator(color: _theme.primaryColor),
              ),
              beforeLineStyle: LineStyle(color: _theme.primaryColor),
              afterLineStyle: LineStyle(color: _theme.primaryColor),
              endChild: TimelineChild(
                child: Text(_trial.interventionsInOrder[0].name,
                    style: _theme.textTheme.headline6.copyWith(color: _theme.primaryColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconIndicator extends StatelessWidget {
  final Color color;

  const IconIndicator({this.color, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color ?? Theme.of(context).accentColor),
    );
  }
}

class TimelineChild extends StatelessWidget {
  final Widget child;

  const TimelineChild({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minHeight: 100),
      child: Center(
        child: child,
      ),
    );
  }
}
