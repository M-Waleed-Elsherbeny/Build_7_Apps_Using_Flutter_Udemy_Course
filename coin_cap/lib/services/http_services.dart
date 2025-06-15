import 'dart:developer';

import 'package:coin_cap/models/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HTTPServices {
  final dio = Dio();

  AppConfig? _appConfig;
  String? _baseUrl;

  HTTPServices() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _baseUrl = _appConfig!.baseUrlEndPoint;
  }

  Future<Response> getUrlData(String path) async {
    try {
      String finalUrl = '$_baseUrl$path';
      String apiKey = _appConfig!.apiKey;
      Map<String, dynamic> headers = {
        'x_cg_demo_api_key': apiKey,
      };
      Response response = await dio.get(
        finalUrl,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      log("Error in HTTPServices : ${e.toString()}");
      rethrow;
    }
  }
}
