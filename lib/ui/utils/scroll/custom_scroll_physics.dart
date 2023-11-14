import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final double scrollSpeedFactor;

  const CustomScrollPhysics({this.scrollSpeedFactor = 1.0, ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(scrollSpeedFactor: scrollSpeedFactor, parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return super.applyPhysicsToUserOffset(position, offset * scrollSpeedFactor);
  }
}