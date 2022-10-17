import 'package:flutter/material.dart';
import 'package:tres_astronautas_flutter/src/pages/diseno_page.dart';
import 'package:tres_astronautas_flutter/src/pages/matriz.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    'matriz': (BuildContext context) => Matriz(),
    'diseno_page': (BuildContext context) => DisenoPage(),
  };
}