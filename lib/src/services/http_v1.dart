

import 'package:dio/dio.dart';
import 'package:tres_astronautas_flutter/src/envitoments.dart';


class HttpV1 {
  var dio = Dio();
  final String _api = enviroments.url;
  final String apiKey = enviroments.apiKey;

  Future<dynamic> buscar({String q = ''}) async {
    try {
      dio.options.headers["Content-Type"] = "multipart/form-data";
      dio.options.headers["Accept"] = "application/json";
      var response = await dio.get("$_api?q=$q&api_key=$apiKey");
      return response.data;
      } catch (e) {
        print("EL ERRROR >>>> ${e.toString()}");
      }
    }

}