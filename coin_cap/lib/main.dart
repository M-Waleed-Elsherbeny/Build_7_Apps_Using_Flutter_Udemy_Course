import 'dart:convert';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'models/app_config.dart';
import 'pages/home_page.dart';
import 'services/http_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  httpServices();
  // GetIt.instance.get<HTTPServices>().getUrlData("/coins/bitcoin");
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String loadData = await rootBundle.loadString('assets/config/api_key.json');
  // log(loadData);
  Map data = jsonDecode(loadData);
  // log(data['API_KEY']);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(
      baseUrlEndPoint: data['BASE_URL_ENDPOINT'],
      apiKey: data['API_KEY'],
    ),
  );
}

void httpServices() {
  GetIt.instance.registerSingleton<HTTPServices>(
    HTTPServices(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinCap',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF493D9E),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
