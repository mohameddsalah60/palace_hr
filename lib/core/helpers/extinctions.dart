import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName) {
    Navigator.pushReplacementNamed(this, routeName);
  }

  void pop() {
    Navigator.pop(this);
  }

  void canPop() {
    Navigator.canPop(this);
  }
}
