
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/firebase_options.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value)=> Get.put(AuthenticationRepository()));

  runApp(const App());
}


