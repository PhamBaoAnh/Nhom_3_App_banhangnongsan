import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/firebase_options.dart';
import 'package:project/repository/AuthenticationRepository.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value)=> Get.put(AuthenticationRepository()));
  runApp(const App());
}


