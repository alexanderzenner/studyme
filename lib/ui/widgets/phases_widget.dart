import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/phases/phases.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';
import 'package:studyme/ui/widgets/timeline.dart';
import 'package:studyme/ui/widgets/timeline_card.dart';
import 'package:studyme/util/color_map.dart';

class PhasesWidget extends StatefulWidget {
  final Phases phases;
  final bool showDuration;
  final int activeIndex;

  PhasesWidget(
      {@required this.phases,
      this.showDuration = false,
      this.activeIndex = -1});

  @override
  _PhasesWidgetState createState() => _PhasesWidgetState();
}

class _PhasesWidgetState extends State<PhasesWidget> {
  @override
  Widget build(BuildContext context) {
    return Timeline(
        activeIndex: widget.activeIndex,
        height: widget.showDuration ? 71 : 50,
        itemCount: widget.phases.numberOfPhases + 1,
        callback: (int index) {
          Widget _cardContent;
          Widget _textBelowCard;
          Color _cardColor = Colors.white;

          if (index == widget.phases.numberOfPhases) {
            _cardContent = Icon(Icons.flag);
            if (widget.showDuration) {
              _textBelowCard = _buildTotalDurationText();
            }
          } else {
            String letter = widget.phases.phaseSequence[index];
            _cardContent = InterventionLetter(letter,
                isInverted: index < widget.activeIndex);
            if (widget.showDuration) {
              _textBelowCard = _buildPhaseDurationText();
            }
            if (index < widget.activeIndex) {
              _cardColor = colorMap[letter];
            }
          }

          return TimelineCard(
              isActive: index == widget.activeIndex,
              cardChild: _cardContent,
              cardColor: _cardColor,
              belowCardChild: _textBelowCard);
        });
  }

  _buildTotalDurationText() {
    return Text(
      '= ${widget.phases.phaseDuration * widget.phases.numberOfPhases}d',
      style: TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildPhaseDurationText() {
    return Text((widget.phases.phaseDuration.toString() + 'd'),
        overflow: TextOverflow.ellipsis);
  }
}
