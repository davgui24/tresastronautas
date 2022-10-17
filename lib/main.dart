import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tres_astronautas_flutter/src/utils/easy_loading.dart';
import 'package:tres_astronautas_flutter/src/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomAnimation().customEasyLoad();
    return MaterialApp(
      title: 'Tres Astronautas',
      debugShowCheckedModeBanner: false,
      // initialRoute: 'home_page',
      initialRoute: 'matriz',
      routes: routes(),
      builder: EasyLoading.init(),
    );
  }
}
