import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/widgets/error_data.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/models/calendar/academic_events.dart';
import 'package:greycell_app/src/views/calendarViews/event_card.dart';
import 'package:scoped_model/scoped_model.dart';

class MyEventList extends StatelessWidget {
  final bool filter;
  final Function? onFailed;

  MyEventList({this.filter = true, this.onFailed});

  Widget _customScroll() {
    return ScopedModelDescendant(
      builder: (context, _, MainModel mainModel) {
        print("IsFilter: $filter");
        final _list = filter
            ? mainModel.selectedCalendarEvents
            : mainModel.originalEventList;

        return SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int position) {
          if (_list.length == 0)
            return MyErrorData(
              errorMsg: 'No events or holidays',
              subtitle: "",
//                      onRetry: onFailed,
            );
          AcademicEvent _event = _list[position];
          return Container(
            decoration: BoxDecoration(color: Colors.grey[50]),
//                        padding: EdgeInsets.symmetric(),
            child: MyEventCard(
              event: _event,
            ),
          );
        }, childCount: _list.length == 0 ? 1 : _list.length));
      },
    );
  }

  Widget _noSelectedEventFound() {
    return Container();
  }

  Widget _buildList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget? child, MainModel mainModel) {
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
//              controller: _scrollController,
          itemBuilder: (context, position) {
            AcademicEvent _event = mainModel.originalEventList[position];
            return Container(
              decoration: BoxDecoration(color: Colors.grey[50]),
//                        padding: EdgeInsets.symmetric(),
              child: MyEventCard(
                event: _event,
              ),
            );
          },
//          separatorBuilder: (context, index) => Divider(),
          itemCount: mainModel.originalEventList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _customScroll();
  }
}
