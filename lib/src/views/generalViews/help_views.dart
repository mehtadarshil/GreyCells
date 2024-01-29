import 'package:flutter/material.dart';
import 'package:greycell_app/src/views/generalViews/faq_data.dart';

class MyHelpViews extends StatefulWidget {
  @override
  _MyHelpViewsState createState() => _MyHelpViewsState();
}

class _MyHelpViewsState extends State<MyHelpViews> {
  int _currentIndex = -1;
  double minValue = 8.0;

  Widget _buildCompany(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(left: minValue * 2),
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "FAQs",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: Colors.blueGrey[800], fontWeightDelta: 1),
                ),
                SizedBox(
                  height: minValue * 2,
                ),
                Text("We are here to help you")
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/images/help.png",
              fit: BoxFit.contain,
              height: 110,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help"),
      ),
      backgroundColor: Colors.grey[50],
      body: Container(
        padding:
            EdgeInsets.symmetric(vertical: minValue * 2, horizontal: minValue),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            _buildCompany(context),

            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final Map<String, dynamic> faq = faqData[index];
                  return Card(
                    elevation: 0.0,
                    margin: EdgeInsets.symmetric(vertical: minValue * 2),
                    child: InkWell(
                      onTap: () => onTappe(index),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  child: Text(
                                    "${faq['question']}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .apply(),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: minValue * 2,
                                      vertical: minValue),
//                                color: Colors.red,
                                )),
                                Container(
                                  alignment: Alignment.center,
                                  child: Icon(_currentIndex == index
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down),
                                  width: minValue * 5,
                                )
                              ],
                            ),
                            _currentIndex == index
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: minValue * 3,
                                        horizontal: minValue * 2),
                                    child: Text(
                                      "${faq['answer']}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: faqData.length),
//            Align(
//              alignment: Alignment.bottomCenter,
//              child: _buildCompany(context),
//            )
          ],
        ),
      ),
    );
  }

  onTappe(int index) {
    setState(() {
      if (index == _currentIndex) {
        _currentIndex = -1;
      } else {
        _currentIndex = index;
      }
    });
  }
}
