import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/app.dart';
import 'package:idea_tuition_managment_app/di/components/service_locator.dart';


Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}
