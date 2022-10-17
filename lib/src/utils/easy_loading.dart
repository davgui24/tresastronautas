import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }

  customEasyLoad() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 3)
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 80
      ..textColor = Colors.red
      ..radius = 20
      ..backgroundColor = Colors.grey
      ..maskColor = Colors.white
      ..indicatorColor = Colors.red
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
  }
}