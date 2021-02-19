import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Timeline extends StatefulWidget {
  final int activeIndex;
  final double height;
  final int itemCount;
  final Widget Function(int index) callback;

  Timeline(
      {@required this.activeIndex,
      @required this.height,
      @required this.itemCount,
      @required this.callback});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    int offset = -1;
    if (widget.activeIndex >= 0) {
      offset = 0;
    }
    if (widget.activeIndex > 3) {
      offset = widget.activeIndex - 3;
    }
    if (widget.activeIndex > widget.itemCount - 3) {
      offset = widget.activeIndex;
    }

    if (offset >= 0) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scrollController.jumpTo(index: offset));
    }

    return Container(
      height: widget.height,
      child: Scrollbar(
        child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
          itemScrollController: _scrollController,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            return widget.callback(index);
          },
        ),
      ),
    );
  }
}
