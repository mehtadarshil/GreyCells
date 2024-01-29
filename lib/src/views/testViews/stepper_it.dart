//import 'package:flutter/material.dart';
//
//class MyStacker extends StatelessWidget {
//  /// Item inside Container
//  final List<String> stepperContent;
//
//  /// Shape Size: default = 30.0
//  /// BoxShape.circle / BoxShape.rectangle
//  final double shapeSize;
//
//  /// [hasScrollable] true for scrollable shapes
//  final bool hasScrollable;
//
//  /// The height of divider.
//  final double dividerHeight;
//
//  /// Color for Divider
//  final Color dividerColor;
//
//  /// Shape of Stepper
//  final BoxShape shape;
//  final double dividerWidth;
//
//  double minValue = 8.0;
//  int _currentIndex = 0;
//
//  MyStacker(
//      {this.stepperContent = const ["J", "F", "J", "F"],
//      this.shapeSize = 30.0,
//      this.hasScrollable = false,
//      this.dividerHeight = 5.0,
//      this.dividerColor,
//      this.shape = BoxShape.circle,
//      this.dividerWidth = 135.0});
//
//  Widget _buildContShape(String text, int index) {
//    return GestureDetector(
//      onTap: () {
//        print("Stepper No ${index + 1} is Tapped..");
//      },
//      child: Container(
//        height: shapeSize,
//        width: 30.0,
////            padding: EdgeInsets.all(minValue * 2),
//        decoration: BoxDecoration(
//          color: Colors.redAccent,
//          shape: shape,
//        ),
//        child: Center(child: Text(text)),
//      ),
//    );
//  }
//
//  List<Widget> _buildChildren() {
//    return List<Widget>.generate(stepperContent.length, (int index) {
//      return _buildContShape(stepperContent[index], index);
//    });
//  }
//
//  Widget _fixedSizedWidget() {
//    return Stack(
//      alignment: Alignment.center,
//      children: <Widget>[
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: _buildChildren(),
//        ),
//        Positioned(
//          top: 2,
//          child: Card(
//            color: Colors.green,
//            elevation: 5.0,
//            child: Container(
//                alignment: Alignment.center,
//                height: 55.0,
//                width: 125.0,
//                child: Text("Test")),
//          ),
//        )
//      ],
//    );
//  }
//
//  // Scrollable
//  Widget _buildScrollable() {
//    return Container(
//      height: shapeSize,
//      child: ListView.builder(
//        scrollDirection: Axis.horizontal,
//        itemCount: stepperContent.length,
//        itemBuilder: (context, index) {
//          return _buildScrollableStepper(stepperContent[index], index);
//        },
//      ),
//    );
//  }
//
//  Widget _buildScrollableStepper(String text, int index) {
//    print(text);
//    return Container(
//      width: dividerWidth,
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: <Widget>[
//          _buildContShape(text, index),
//          index == stepperContent.length - 1
//              ? Container()
//              : Expanded(
//                  child: Center(
//                    child: Divider(
//                      color: dividerColor ?? Colors.grey[300],
//                      thickness: 15.0,
//                    ),
//                  ),
//                )
//        ],
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Stack(
//        alignment: Alignment.center,
//        children: <Widget>[
//          hasScrollable
//              ? Container()
//              : Container(
//                  height: dividerHeight,
//                  width: MediaQuery.of(context).size.width,
//                  decoration: BoxDecoration(
//                    color: dividerColor ?? Colors.grey[300],
//                    shape: BoxShape.rectangle,
//                  ),
//                ),
//          Container(
//            height: 350.0,
//            child: hasScrollable ? _buildScrollable() : _fixedSizedWidget(),
//          )
//        ],
//      ),
//    );
//  }
//}
