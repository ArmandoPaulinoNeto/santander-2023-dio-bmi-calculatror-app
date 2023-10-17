import 'package:bmi_calculator_app/pages/app_widget.dart';
import 'package:flutter/material.dart';

import 'config/hive_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();  

  runApp(AppWidget());
}
