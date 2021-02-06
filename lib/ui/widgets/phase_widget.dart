import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:studyme/models/schedule/trial_phases.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';
import 'package:studyme/util/color_map.dart';

class PhasesWidget extends StatefulWidget {
  final TrialPhases schedule;
  final bool showDuration;
  final int activeIndex;

  PhasesWidget(
      {@required this.schedule,
      this.showDuration = false,
      this.activeIndex = -1});

  @override
  _PhasesWidgetState createState() => _PhasesWidgetState();
}

class _PhasesWidgetState extends State<PhasesWidget> {
  ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.activeIndex > 0) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollController.jumpTo(index: widget.activeIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.showDuration ? 71 : 50,
      child: Scrollbar(
        child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
          itemScrollController: _scrollController,
          itemCount: widget.schedule.numberOfPhases + 1,
          itemBuilder: (context, index) {
            Widget _cardContent;
            Widget _textBelowCard;
            Color _cardColor = Colors.white;

            if (index == widget.schedule.numberOfPhases) {
              _cardContent = Icon(Icons.flag);
              if (widget.showDuration) {
                _textBelowCard = _buildTotalDurationText();
              }
            } else {
              String letter = widget.schedule.phaseSequence[index];
              _cardContent = InterventionLetter(letter,
                  isInverted: index < widget.activeIndex);
              if (widget.showDuration) {
                _textBelowCard = _buildPhaseDurationText();
              }
              if (index < widget.activeIndex) {
                _cardColor = colorMap[letter];
              }
            }

            return _buildStackedCard(index == widget.activeIndex, _cardContent,
                _cardColor, _textBelowCard);
          },
        ),
      ),
    );
  }

  _buildTotalDurationText() {
    return Text(
      '= ${widget.schedule.phaseDuration * widget.schedule.numberOfPhases}d',
      style: TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildPhaseDurationText() {
    return Text((widget.schedule.phaseDuration.toString() + 'd'),
        overflow: TextOverflow.ellipsis);
  }

  _buildStackedCard(
      bool isActive, Widget cardChild, Color cardColor, Widget belowCardChild) {
    return Container(
      width: 50,
      child: Column(children: [
        Container(
            height: 50,
            child: Card(
                shape: isActive
                    ? RoundedRectangleBorder(
                        side: new BorderSide(
                            color: Theme.of(context).primaryColor, width: 4.0),
                        borderRadius: BorderRadius.circular(4.0))
                    : null,
                color: cardColor,
                child: Center(child: cardChild))),
        if (belowCardChild != null) belowCardChild
      ]),
    );
  }
}
