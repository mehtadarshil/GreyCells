import 'package:flutter/material.dart';

class MyCustomSearchDeligate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text("Hello Result"),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text("Hello Search"),
      ),
    );
  }
}
