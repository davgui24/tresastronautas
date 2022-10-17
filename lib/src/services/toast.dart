import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tres_astronautas_flutter/src/utils/responsive.dart';

class ToastService {
  //  showToastCenter({@required context, @required text, @required durationSeconds}){
  //    Toast.show(text, context,
  //             duration: 3, gravity: Toast.CENTER);
  //  }

  showToastCenter(
      {@required context, @required text, @required durationSeconds}) {
    final Responsive responsive = Responsive.of(context);
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: durationSeconds,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: responsive.ip(2),
    );
  }
}

ToastService toastService = ToastService();