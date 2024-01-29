import 'package:flutter/material.dart';
import 'package:greycell_app/src/commons/search/custom_search_delegate.dart';
import 'package:greycell_app/src/manager/main_model.dart';
import 'package:greycell_app/src/views/calendarViews/event_list.dart';
import 'package:greycell_app/src/views/calendarViews/mycalendar.dart';
import 'package:scoped_model/scoped_model.dart';

class MyCalendarAppbar extends StatelessWidget {
  final double minValue = 8.00;

  void _openSearchStuffs(BuildContext context) {
    showSearch(context: context, delegate: MyCustomSearchDeligate());
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColorDark;
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget? child, MainModel model) {
        return SliverAppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: Colors.white70,
              ),
              onPressed: () => Navigator.of(context).pop()),
          elevation: 5,
          centerTitle: false,
          title: Text('Academic Calendar'),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.indigo[800],
//          expandedHeight: MediaQuery.of(context).size.height / 2,
          expandedHeight: 370,
//          pinned: false,
//          floating: true,
//          snap: false,
          floating: true,
          pinned: true,
          snap: true,
          flexibleSpace: FlexibleSpaceBar(
            background: MyCalendar(),
          ),
          actions: <Widget>[
//            IconButton(
//                icon: Icon(
//                  Icons.search,
//                  color: Colors.white,
//                ),
//                onPressed: () => _openSearchStuffs(context)),
            IconButton(
                tooltip: "All Events",
                icon: Icon(
                  Icons.all_inclusive,
                  color: Colors.white,
                ),
                onPressed: () {
                  _openModalSheet(context, model);
                  model.onResetToDefault();
                }),
            SizedBox(
              width: 15.0,
            )
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
        height: 50,
        padding: EdgeInsets.all(8),
        child: TextField(
            onChanged: onTextChange,
            decoration: InputDecoration(
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search something ...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero)));
  }

  void onTextChange(String value) {
    print(value);
  }

  void _openModalSheet(BuildContext context, MainModel model) async {
    await showModalBottomSheet(
        context: context,
        builder: (contex) {
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.red,
//              borderRadius: BorderRadius.only(
//                  topRight: Radius.circular(minValue * 2),
//                  topLeft: Radius.circular(minValue * 2)),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      vertical: minValue, horizontal: minValue * 2),
                  color: Theme.of(context).primaryColorDark,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "All Academic Events",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.white, fontWeightDelta: 1),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white60,
                          ),
                          onPressed: () => Navigator.of(context).pop())
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      MyEventList(
                        filter: false,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
    print("Exe");
    // Get Current Data To Ui
    model.onMonthChanged(
      DateTime.now(),
    );
  }
}
