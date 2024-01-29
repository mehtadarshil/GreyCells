import 'package:flutter/material.dart';

class PaymentSearchFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 243, 243, 1),
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search you're looking for",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black87,
                  )),
            ),
          ),
        ),
//        Checkbox(
//          value: true,
//          activeColor: Colors.white,
//          onChanged: onAllSelectChanged,
//          checkColor: Colors.black87,
//          hoverColor: Theme.of(context).primaryColor,
//        ),
      ],
    );
  }
}
